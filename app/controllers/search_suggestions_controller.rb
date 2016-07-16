class SearchSuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: User.terms_for(params[:term])
  end
end
