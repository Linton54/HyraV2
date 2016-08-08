require 'rails_helper'

describe Post, type: :model do

  it "should be valid" do
    expect(build(:post)).to be_valid
  end

  it "content should be present" do
    expect(build(:post, content: "   ")).not_to be_valid
  end

  it "content should be > 15 and " do
    text = "a" * 14
    expect(build(:post, content: text)).not_to be_valid
  end

  it "title should be present" do
    expect(build(:post, title: "   ")).not_to be_valid
  end

  it "title should be > 1 and < 150" do
    title = "a" * 151
    expect(build(:post, title: title)).not_to be_valid
  end

  it "title should be banana" do
    new = build(:post, title: "Banana")
    expect(new.title).to eq("Banana")
  end

  it "category should be present" do
    expect(build(:post, category: " ")).not_to be_valid
  end

  it "category should be present" do
    expect(build(:post, category: "Missing You")).to be_valid
  end

  it "order should be most recent" do
    old = create(:post)
    new = create(:post)
    expect(Post.first).to eq(new)
    expect(Post.last).to eq(old)
  end

  it "#user_username" do
    user = build(:user, username: "marv")
    post = build(:post, user: user)
    expect(post.user_username).to eq("marv")
  end

  it "#user_avatar_url" do
    user = build(:user)
    post = build(:post, user: user)
    expect(post.user_avatar_url).to eq(user.avatar_url)
  end
end