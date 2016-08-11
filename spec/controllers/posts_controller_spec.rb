require 'rails_helper'

describe PostsController, type: :controller do

  describe "#index" do
    it "redirect to login when not log in" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#show" do
    it "redirect to login when not log in" do
      get :show, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#create" do
    it "redirect to login when not log in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "create post with valid attributes" do
      login_user
      post :create, post: attributes_for(:post)
      expect(Post.count).to eq(1)
      expect(response).to redirect_to(root_path)
    end

    it "create post with invalid attributes" do
      login_user
      post :create, post: attributes_for(:post, content: " ")
      expect(Post.count).to eq(0)
      expect(response).to render_template(:index)
    end
  end

  describe "#edit" do
      it "redirect to login when not log in" do
        get :edit, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
  end

  describe "#update" do
      it "redirect to login when not log in" do
        put :update, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end

      it "update post with valid attributes" do
        login_user
        p = create(:post)
        put :update, id: p.id, post: attributes_for(:post)
        expect(response).to redirect_to(root_path)
      end

      it "update post with invalid attributes" do
        login_user
        p = create(:post)
        put :update, id: p.id, post: attributes_for(:post, content: " ")
        expect(response).to render_template(:edit)
      end
  end

  describe "#destroy" do
      it "redirect to login when not log in" do
        delete :destroy, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end

      it "delete post" do
        p = create(:post)
        login_user p.user
        expect(Post.count).to eq(1)
        delete :destroy, id: p.id
        expect(Post.count).to eq(0)
        expect(response).to redirect_to(root_path)
      end
  end
end
