require 'rails_helper'

RSpec.describe Message, type: :model do

  it "content should be present" do
    expect(build(:message, content: " ")).not_to be_valid
  end

  it "recipient should be present" do
    expect(build(:message, recipient: " ")).not_to be_valid
  end

  it "inbox_id should be present" do
    expect(build(:message, inbox_id: " ")).not_to be_valid
  end

  it "should belong to an inbox" do
    inbox = create(:inbox)
    message = create(:message, inbox_id: inbox.id)
    expect(message.inbox_id).to eq(inbox.id)
  end
end
