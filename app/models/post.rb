class Post < ActiveRecord::Base

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user, counter_cache: true

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 15 }
  validates :title, presence: true, length: { in: 1..150 }
  validates :category, presence: true

  delegate :username, :avatar_url, to: :user, prefix: true

  default_scope -> { order(created_at: :desc) }

  def username
    user_username
  end

  def avatar_url
    user_avatar_url
  end
end
