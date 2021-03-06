class PostsController < ApplicationController
  include AmazonSignature

  before_action :authenticate_user!, except: [:show]
  before_action :find_user, only: [:destroy]
  before_action :find_post, only: [:update, :edit, :show]

  def index
    @post = current_user.posts.build
    @hash = AmazonSignature::data_hash
  end

  def show
  end

  def create
    @hash = AmazonSignature::data_hash
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post is successfully posted"
      redirect_to root_url
    else
      render 'index'
    end
  end

  def edit
    redirect_to root_url if @post.user != current_user
    @category = @post.category
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post is successfully updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post is successfully deleted"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :title, :category)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def find_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end