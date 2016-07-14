class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_except(current_user, 10).shuffle
  end

  def show
    @user = User.find_by(username: params[:id])
    redirect_to root_url if @user.nil?
  end
end
