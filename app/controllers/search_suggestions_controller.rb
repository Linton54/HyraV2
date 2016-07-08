class SearchSuggestionsController < ApplicationController
  def index
    render json: User.terms_for(params[:term])
  end
end
