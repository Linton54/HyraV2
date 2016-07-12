class Message < ActiveRecord::Base
  belongs_to :inbox

  validates :content, presence: true
  validates :recipient, presence: true
  validates :inbox_id, presence: true

  default_scope -> { order(created_at: :asc) }
end
