class Post < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 15 }
  validates :title, presence: true, length: { in: 1..150 }

  default_scope -> { order(created_at: :desc) }
end
