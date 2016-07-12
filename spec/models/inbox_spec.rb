require 'rails_helper'

RSpec.describe Inbox, type: :model do

  it "should be valid message" do
    expect(create(:inbox)).to be_valid
  end

  it "sender_id should be present" do
    expect(build(:inbox, sender_id: " ")).not_to be_valid
  end

  it "sender_id should be present" do
    expect(build(:inbox, receiver_id: " ")).not_to be_valid
  end
end
