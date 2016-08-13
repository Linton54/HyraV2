class HomePagesController < ApplicationController
  include HomePagesHelper

  before_action :check_user, only: [:home]
  before_action :set_category, only: [:show]

  def home
    user_signed_in? ? @posts = current_user.following_posts : @posts = Post.all.limit(10).includes(:user)
    #paginate(page: params[:page], per_page: 10)
  end

  def index

  end

  def show
    @title = set_category.upcase
    @categories = Post.where(category: set_category).includes(:user)
  end

  private
  #check wethere the user has not post any post or friend post then flash make friends
  def check_user
    #redirect_to new_user_session_path unless user_signed_in? #uncomment to view posts without signing in
  end

  def set_category
    arry = %w[Love Apology Farewell]
    arry.include?(params[:category]) ? params[:category] : humanize_url(params[:category])
  end
end