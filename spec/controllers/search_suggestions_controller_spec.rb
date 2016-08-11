require 'rails_helper'

describe SearchSuggestionsController, type: :controller do

  describe "#index" do
    it "should redirect to index when user not logged in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should return usernames when term is 'm' " do
      user = create(:user, username: "marv")

      login_user user
      get :index, term: 'm', format: :json
      expect(assigns(:users)).to eq([user.username])
    end

    it "should return no usernames when term is ' ' " do
      user = create(:user, username: "marv")

      login_user user
      get :index, term: ' ', format: :json
      expect(assigns(:users).empty?).to be true
    end
  end
end
