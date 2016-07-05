require 'rails_helper'

RSpec.describe HomePagesController, type: [:request, :controller] do


    it "it should redirect to log in when not logged in" do
      get '/'
      expect(response).to redirect_to(new_user_session_path)
    end
end
