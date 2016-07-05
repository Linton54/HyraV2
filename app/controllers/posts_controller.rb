class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:destroy]

  def index
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post is successfully posted"
      redirect_to root_url
    else
      render 'index'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post is successfully deleted"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :title)
  end

  def find_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end