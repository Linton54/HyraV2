require 'rails_helper'

RSpec.describe UsersController, type: [:request, :controller] do

    it "should redirect index when not logged in" do
      get '/users/:id', id: 1
      expect(response).to redirect_to(new_user_session_path)
    end
end
