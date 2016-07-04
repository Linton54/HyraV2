class HomePagesController < ApplicationController
  before_action :check_user, only: [:home]
  def home
  end

  private
  #check wethere the user has not post any post or friend post then flash make friends
  def check_user
    redirect_to new_user_session_path unless user_signed_in?
  end
end
