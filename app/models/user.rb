class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  VALID_USERNAME_REGEX = /\A[\w\s-]*\z/i
  validates :username, presence: true, uniqueness: true, length: { in: 3..8 },
            format: { with: VALID_USERNAME_REGEX }

  #User Avatar
  has_attached_file :avatar, styles: {thumb: "150x150"},
                    default_url: "https://s3.amazonaws.com/images-hyra/user_default.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 2.megabytes

  #User Profile_Backgorund_Avatar
  has_attached_file :profile_background_avatar, styles: { large: "x400" },
                    default_url: "https://s3.amazonaws.com/images-hyra/background_default.jpg"

  validates_attachment_content_type :profile_background_avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :profile_background_avatar, :less_than => 2.megabytes

  #Messages
  has_many :sent_messages, class_name: "Inbox", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Inbox", foreign_key: "receiver_id", dependent: :destroy

  #Posts
  has_many :posts, dependent: :destroy

  #Relationships
  #following
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  #follower
  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  #retrieve user except current_user
  scope :all_except, ->(user, count) { where.not(id: (user.following.ids << user.id) ).limit(count) }

  #User Methods
  def find_user_by_username(user)
    User.find_by(username: user)
  end

  #Relationship Methods
  def follow(other_user)
    User.increment_counter(:following_count, self.id)
    User.increment_counter(:followers_count, other_user.id)
    following_relationships.create(followed_id: other_user.id)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def unfollow(other_user)
    User.decrement_counter(:following_count, self.id)
    User.decrement_counter(:followers_count, other_user.id)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  #Search user
  def self.terms_for(prefix)
    where("username like?", prefix + "%").limit(10).pluck(:username)
  end

  #Inbox is unique
  #sender receiver
  def inbox_exists?(sender, receiver)
    Inbox.exists?(sender_id: sender.id, receiver_id: receiver.id)
  end

  def find_inbox(sender, receiver)
    Inbox.find_by(sender_id: sender.id, receiver_id: receiver.id)
  end

  def create_inbox(receiver)
    sent_messages.create(receiver_id: receiver.id)
  end

  #Distinct receive messages
  def inbox
    received_messages.includes(:sender)
  end

  def avatar_url
    avatar.url(:thumb)
  end

  def profile_background_avatar_url
    profile_background_avatar.url(:large)
  end
end