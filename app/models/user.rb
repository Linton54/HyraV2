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
  has_attached_file :avatar, styles: {thumb: "150x150>"},
                    default_url: "https://s3.amazonaws.com/images-hyra/user_default.png"
  #default_url: "https://s3.amazonaws.com/hyraweb/user.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 2.megabytes

  #User Profile_Backgorund_Avatar
  has_attached_file :profile_background_avatar, styles: { large: "x400" },
                    default_url: "https://s3.amazonaws.com/images-hyra/background_default.jpg"

  validates_attachment_content_type :profile_background_avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :profile_background_avatar, :less_than => 2.megabytes

  #Posts
  has_many :posts, dependent: :destroy
end
