require 'rails_helper'

describe HomePagesController, type: :controller do

  describe "#Home" do
    it "should show 10 posts if there are 10 posts created even not log in" do
      posts = create_list(:post, 10)
      get :home
      expect(assigns(:posts).count).to eq(posts.count)
    end

    it "should show 0 posts if there are 0 posts created even not log in" do
      get :home
      expect(assigns(:posts).count).to eq(0)
    end
  end

  describe "#Show" do

    it "should redirect when not logged in" do
      get :show, category: "Life"
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should return categories count" do
      login_user
      arry = create_list(:post, 3, category: "I Love You")
      get :show, category: "ILoveYou" #Remove space, str_free is called to remove space
      expect(assigns(:categories).count).to eq(arry.count)
    end
  end
end
