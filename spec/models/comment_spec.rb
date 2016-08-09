require 'rails_helper'
include ActionView::Helpers::DateHelper

RSpec.describe Comment, type: :model do

  it "with valid attributes #Post" do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it "with valid attributes #User" do
    comment = build(:comment, commentable_type: "User")
    expect(comment).to be_valid
  end

  it "#content should be present" do
    comment = build(:comment, content: " ")
    expect(comment).not_to be_valid
  end

  it "#commentable_id should be present" do
    comment = build(:comment, commentable_id: " ")
    expect(comment).not_to be_valid
  end

  it "#commentable_type should be present" do
    comment = build(:comment, commentable_id: " ")
    expect(comment).not_to be_valid
  end

  it "#user_id should be present" do
    comment = build(:comment, user_id: " ")
    expect(comment).not_to be_valid
  end

  it "#user_username" do
    user = create(:user)
    comment = build(:comment, user_id: user.id)
    expect(comment.user_username).to eq(user.username)
  end

  it "#user_avatar_url" do
    user = create(:user)
    comment = build(:comment, user_id: user.id)
    expect(comment.user_avatar_url).to eq(user.avatar_url)
  end

  it "#time_ago" do
    user = create(:user)
    comment = create(:comment, user_id: user.id)
    expect(comment.time_ago).to eq(time_ago_in_words(comment.created_at))
  end
end
