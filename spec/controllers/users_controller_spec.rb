require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do
    it "should redirect index when not logged in" do
      get :index, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should return users not including current_user" do
      current_user = create(:user)
      users = create_list(:user, 5)
      login_user current_user
      get :index
      expect(assigns(:users).include?(current_user)).to be false
      expect(assigns(:users).count).to eq(5)
    end
  end

  describe "#show" do
    it "should redirect index when not logged in" do
      get :show, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should show user" do
      user = create(:user)
      login_user user
      get :show, id: user.username
      expect(assigns(:user).username).to eq(user.username)
      expect(assigns(:posts).count).to eq(0)
    end
  end
end
