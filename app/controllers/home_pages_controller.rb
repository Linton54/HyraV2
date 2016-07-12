class HomePagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :check_user, only: [:home]
  before_action :set_category, only: [:show]

  def home
    @messages = current_user.received_messages.all
    @posts = Post.all #paginate(page: params[:page], per_page: 10)
  end

  def show
    @title = set_category.upcase
    @categories = Post.where(category: set_category)
  end

  private
  #check wethere the user has not post any post or friend post then flash make friends
  def check_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_category
    params[:category]
  end
end