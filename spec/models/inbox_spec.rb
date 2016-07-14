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

  it "should have many messages" do
    inbox = create(:inbox_with_messages)
    expect(inbox.messages.count).to eq(2)
  end

  it "should destroy messages associated to the inbox" do
    inbox = create(:inbox_with_messages)
    expect(inbox.messages.count).to eq(2)
    Inbox.find(inbox.id).destroy
    expect(Inbox.count).to eq(Message.count)
  end

  it "should return the only messages between sender and receiver" do
    inbox1 = create(:inbox, sender_id: 1, receiver_id: 2)
    inbox2 = create(:inbox, sender_id: 2, receiver_id: 1)

    message1 = create(:message, inbox_id: inbox1.id)
    message2 = create(:message, inbox_id: inbox2.id)

    expect(inbox1.find_sender_inbox).to eq([inbox2.id, inbox1.id])
    expect(inbox2.find_sender_inbox).to eq([inbox1.id, inbox2.id])
    expect([message2.inbox_id,  message1.inbox_id]).to include(inbox1.id, inbox2.id)

    expect(inbox1.conversations.ids).to eq([inbox1.id, inbox2.id])
    expect(inbox2.conversations.ids).to eq([inbox1.id, inbox2.id])
  end

  it "should return the only messages between sender == receiver" do
    inbox = create(:inbox, sender_id: 1, receiver_id: 1)

    message1 = create(:message, inbox_id: inbox.id)
    message2 = create(:message, inbox_id: inbox.id)

    expect(inbox.find_sender_inbox).to eq([inbox.id])
    inbox.conversations.each do |msg|
      expect(msg.inbox_id).to eq(inbox.id)
    end
  end
end
