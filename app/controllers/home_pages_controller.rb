class HomePagesController < ApplicationController
  include HomePagesHelper

  before_action :check_user, only: [:home]
  before_action :set_category, only: [:show]

  def home
    if user_signed_in?
      @posts = current_user.following_posts.paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.includes(:user).paginate(page: params[:page], per_page: 10)
    end
  end

  def index

  end

  def show
    @title = set_category.upcase
    @count = Post.category_count(set_category)
    @categories = Post.where(category: set_category).includes(:user).paginate(page: params[:page], per_page: 5)
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