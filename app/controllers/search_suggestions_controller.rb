class SearchSuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.terms_for(params[:term].downcase)
    render json: @users.to_json(only: [:username], methods: [:avatar_url])
  end
end
