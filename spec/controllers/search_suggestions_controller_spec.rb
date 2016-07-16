require 'rails_helper'

RSpec.describe SearchSuggestionsController, type: [:request, :controller] do

    it "should redirect to index when user not logged in" do
      get '/search_suggestions'
      expect(response).to redirect_to(new_user_session_path)
    end
end
