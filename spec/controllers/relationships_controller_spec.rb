require 'rails_helper'

describe RelationshipsController, type: :controller do

  describe "#create" do
    it "should redirect create when not log in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "follow user" do
      user1 = create(:user)
      user2 = create(:user)
      login_user user1
      expect(user1.following.count).to eq(0)
      post :create, id: user2.id, format: :js
      expect(user1.following.count).to eq(1)
    end
  end

  describe "#destroy" do
    it "should redirect destroy when not log in" do
      delete :destroy, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "unfollow user" do
      user1 = create(:user)
      user2 = create(:user)
      login_user user1
      post :create, id: user2.id, format: :js
      expect(user1.following.count).to eq(1)
      delete :destroy, id: user2.id, format: :js
      expect(user1.following.count).to eq(0)
    end
  end
end
