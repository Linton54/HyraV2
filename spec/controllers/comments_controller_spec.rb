require 'rails_helper'

describe CommentsController, type: :controller  do

  describe "#index" do
    it "it redirect user when not log in" do
      get :index, post_id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns json" do
      post = create(:post)
      login_user post.user
      get :index, post_id: post.id
      expect(response.content_type).to eq("application/json")
    end
  end

  describe "#create" do
    it "user not log in has a 400 status code #unauthorized" do
      post :create, {post_id: 1, comment: attributes_for(:comment), format: :json}
      expect(response.status).to eq(401)
    end

    it "create comment" do
      p = create(:post)
      login_user
      post :create, {post_id: p.id, comment: attributes_for(:comment), format: :json}
      expect(Comment.count).to eq(1)
      expect(response.content_type).to eq("application/json")
     end
  end

  describe "#destroy" do
    it "user not log in has a 400 status code #unauthorized" do
      comment = create(:comment)
      delete :destroy, {post_id: 1, id: comment.id, format: :json}
      expect(Comment.count).to eq(1)
      expect(response.status).to eq(401)
    end

    it "delete comment" do
      p = create(:post)
      c = create_list(:comment, 3, user_id: p.user.id)
      login_user p.user
      delete :destroy, {post_id: p.id, id: c[2].id, format: :json}
      expect(Comment.count).to eq(2)
      expect(response.content_type).to eq("application/json")
    end
  end
end
