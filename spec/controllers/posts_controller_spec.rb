require 'rails_helper'

RSpec.describe PostsController, type: [:request, :controller] do

  it "should redirect to index when not logged in" do
    get '/posts'
    expect(response).to redirect_to(new_user_session_path)
  end

  it "should redirect create when not logged in" do
    @post = create(:post)
    post '/posts', post: { title: @post.title, content: @post.content }
    expect(response).to redirect_to(new_user_session_path)
  end

  it "shoult redirect delete when not logged in" do
    delete '/posts/:id', id: 1
    expect(response).to redirect_to(new_user_session_path)
  end

  it "shoud redirect destroy for wrong post" do
    @post = create(:post)
    @post2 = create(:post)
    login(@post.user)
    expect(Post.count).to eq(2)
    delete '/posts/:id', id: @post2
    expect(Post.count).to eq(2)
  end
end
