class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:index, :create, :destroy]
  before_action :find_comment, only: [:destroy]

  def index
    render json: @post.comments.all
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.json { render json: @comment }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.json { render json: @post.comments }
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
