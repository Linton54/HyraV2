require 'rails_helper'

RSpec.describe HomePagesController, type: [:request, :controller] do

    it "should redirect index when not logged in" do
      get '/'
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect show when not logged in" do
      get '/category/:category', category: "Life"
      expect(response).to redirect_to(new_user_session_path)
    end
end
