class Message < ActiveRecord::Base
  belongs_to :inbox, counter_cache:  true

  validates :content, presence: true
  validates :recipient, presence: true
  validates :inbox_id, presence: true

end
