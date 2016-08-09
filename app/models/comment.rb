class Comment < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :commentable_type, presence: true
  validates :commentable_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  delegate :username, :avatar_url, to: :user, prefix: true

  def as_json(options={})
    super(only: [:id, :content], methods: [:user_id, :time_ago, :user_username, :user_avatar_url])
  end

  def time_ago
    time_ago_in_words(created_at)
  end
end
