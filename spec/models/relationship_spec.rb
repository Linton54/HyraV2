require 'rails_helper'

RSpec.describe Relationship, type: :model do

  it "should be valid relationship" do
    expect(build(:relationship, follower_id: 1, followed_id: 2)).to be_valid
  end

  it "should require user_id(follower)" do
    expect(build(:relationship, follower_id: " ", followed_id: 2)).to_not be_valid
  end

  it "should require followed_id(following)" do
    expect(build(:relationship, follower_id: 1, followed_id: " ")).to_not be_valid
  end
end
