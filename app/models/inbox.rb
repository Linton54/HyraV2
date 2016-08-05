class Inbox < ActiveRecord::Base
 belongs_to :sender, class_name: "User", foreign_key: "sender_id"
 belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

 has_many :messages, dependent: :destroy

 validates :sender_id, presence: true
 validates :receiver_id, presence: true

 delegate :username, :avatar_url, to: :sender, prefix: true

 def conversations
   Message.where(inbox_id: find_sender_inbox)
 end

 def find_sender_inbox
   keys = Inbox.where(sender_id: receiver_id, receiver_id: sender_id).pluck(:id)
   keys << self.id
   keys.uniq
 end
end
