class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_except(current_user, 10).shuffle
  end

  def show
    @user = User.find_by(username: params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end
end