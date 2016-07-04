class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  VALID_USERNAME_REGEX = /\A[\w\s-]*\z/i
  validates :username, presence: true, uniqueness: true, length: { in: 3..8 },
            format: { with: VALID_USERNAME_REGEX }
end
