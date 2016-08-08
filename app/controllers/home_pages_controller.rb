class HomePagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :check_user, only: [:home]
  before_action :set_category, only: [:show]

  def home
    @posts = Post.all.limit(10).includes(:user) #paginate(page: params[:page], per_page: 10)
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
    arry = %w[Heartbreak Happiness]
    arry.include?(params[:category]) ? params[:category] : humanize_url(params[:category])
  end

  #Humanize category in the url
  #/category/ILoveYou instead of
  # /category/I20%Love20%You
  def humanize_url(category)
      case category
        when "ILoveYou"
           "I Love You"
        when "LongDistance"
           "Long Distance"
        else
          "Missing You"
      end
  end
end