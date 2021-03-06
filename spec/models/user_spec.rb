require 'rails_helper'

describe User, type: :model do

  it "create user with valid attributes" do
    expect(create(:user)).to be_valid
  end

  it "reject signup without or invalid usernmae" do
    expect(build(:user, username: "   ")).not_to be_valid
  end

  it "has a unique username" do
    expect(create(:user, username: "Marv")).to be_valid
    expect(build(:user, username: "Marv")).not_to be_valid
  end

  it "is invalid without email" do
    email = "     "
    expect(build(:user, email: email)).to_not be_valid
  end

  it "should accept username minimum length of 3 and max is 8" do
    username = %w{ max masd1 23m masd5312 032m 9321jsak }
    username.each do |u|
      expect(build(:user, username: u)).to be_valid
    end
  end

  it "should reject username minimum length of < 3 and max is > 8" do
    username = %w{ 3asda1231 dasd51234 23 ad 1a }
    username.each do |u|
      expect(build(:user, username: u)).not_to be_valid
    end
  end

  it "should reject username with special characters" do
    username = %w{ @21 ka.@ 1a@ a32% da%12.3 asd@3/4@ }
    username.each do |u|
      expect(build(:user, username: u)).not_to be_valid
    end
  end

  it "reject password length < 6" do
    password = "a" * 5
    expect(build(:user, password: password)).not_to be_valid
  end

  it "accept password length >= 6" do
    password = "a" * 10
    expect(build(:user, password: password)).not_to be_valid
  end

  it "should reject invalid email address" do
    emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    emails.each do |email|
      expect(build(:user, email: email)).not_to be_valid
    end
  end

  it "should accept valid email address" do
    emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    emails.each do |email|
      expect(build(:user, email: email)).to be_valid
    end
  end

  it "should reject duplicate email" do
    expect(create(:user, email: "user1@yahoo.com")).to be_valid
    expect(build(:user, email: "user1@yahoo.com")).not_to be_valid
  end

  it "associated posts should be destroyed" do
    user = create(:user_with_posts)
    expect(user.posts.count).to eq(2)
    user.destroy
    expect(Post.count).to eq(0)
  end

  it "should follow and unfollow a user" do
    marv = create(:user)
    juriz = create(:user)
    expect(marv.following?(juriz)).to be false
    marv.follow(juriz)
    expect(marv.following?(juriz)).to be true
    marv.unfollow(juriz)
    expect(marv.following?(juriz)).to be false
  end

  #attachment
  it { expect have_attached_file(:avatar) }
  it { expect validate_attachment_content_type(:avatar)
                  .allowing('image/png', 'image/gif')
                  .rejecting('text/plain', 'text/xml') }
  it { expect validate_attachment_size(:avatar).less_than(2.megabytes) }
  it { expect have_attached_file(:profile_background_avatar) }
  it { expect validate_attachment_content_type(:profile_background_avatar)
                  .allowing('image/png', 'image/gif')
                  .rejecting('text/plain', 'text/xml') }
  it { expect validate_attachment_size(:profile_background_avatar).less_than(2.megabytes) }

  it "should have default avatar" do
    user = build(:user)
    expect(user.avatar.url).to eq("https://s3.amazonaws.com/images-hyra/user_default.png")
  end

  it "should have default profile_background_avatar" do
    user = build(:user)
    expect(user.profile_background_avatar.url).to eq("https://s3.amazonaws.com/images-hyra/background_default.jpg")
  end

  it "should have the right path for avatar and profile_background_avatarqq" do
    user = create(:user,
                  avatar_file_name: 'ngc.png',
                  avatar_content_type: 'image/png',
                  avatar_file_size: 1024,
                  profile_background_avatar_file_name: 'background.png',
                  profile_background_avatar_content_type: 'image/png',
                  profile_background_avatar_file_size: 1024 )
    expect(user.avatar_file_size).to eq(1024)

    expect(user.avatar.url).to eq("/system/users/avatars/000/000/001/original/ngc.png")
    expect(user.avatar(:thumb)).to eq("/system/users/avatars/000/000/001/thumb/ngc.png")
  end
end