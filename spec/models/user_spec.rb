require 'rails_helper'

describe User do

  it "create user with valid attributes" do
    create(:user).should be_valid
  end

  it "reject signup without or invalid usernmae" do
    build(:user, username: "   ").should_not be_valid
  end

  it "has a unique username" do
    create(:user, username: "Marv").should be_valid
    build(:user, username: "Marv").should_not be_valid
  end

  it "is invalid without email" do
    email = "     "
    build(:user, email: email).should_not be_valid
  end

  it "should accept username minimum length of 3 and max is 8" do
    username = %w{ max masd1 23m masd5312 032m 9321jsak }
    username.each do |u|
      build(:user, username: u).should be_valid
    end
  end

  it "should reject username minimum length of < 3 and max is > 8" do
    username = %w{ 3asda1231 dasd51234 23 ad 1a }
    username.each do |u|
      build(:user, username: u).should_not be_valid
    end
  end

  it "should reject username with special characters" do
    username = %w{ @21 ka.@ 1a@ a32% da%12.3 asd@3/4@ }
    username.each do |u|
      build(:user, username: u).should_not be_valid
    end
  end

  it "reject password length < 6" do
    password = "a" * 5
    build(:user, password: password).should_not be_valid
  end

  it "accept password length >= 6" do
    password = "a" * 10
    build(:user, password: password).should_not be_valid
  end

  it "should reject invalid email address" do
    emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    emails.each do |email|
      build(:user, email: email).should_not be_valid
    end
  end

  it "should accept valid email address" do
    emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    emails.each do |email|
      build(:user, email: email).should be_valid
    end
  end

  it "should reject duplicate email" do
    create(:user, email: "user1@yahoo.com").should be_valid
    build(:user, email: "user1@yahoo.com").should_not be_valid
  end
=begin
  it "associated posts should be destroyed" do
    user = create(:user, username: "dsadsad", email: "dasda@yahoo.com")
    user.posts.create(title: "dsada", content: "This is an example words")
    user.posts.count.should == 1
    user.destroy
    Post.count.should == 0
  end

  it "should follow and unfollow a user" do
    marv = create(:user)
    juriz = create(:user)
    marv.following?(juriz) == false
    marv.follow(juriz)
    marv.following?(juriz) == true
    marv.unfollow(juriz)
    marv.following?(juriz) == false
  end

  #attachment
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar)
                  .allowing('image/png', 'image/gif')
                  .rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:avatar).less_than(2.megabytes) }
  it { should have_attached_file(:profile_background_avatar) }
  it { should validate_attachment_content_type(:profile_background_avatar)
                  .allowing('image/png', 'image/gif')
                  .rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:profile_background_avatar).less_than(2.megabytes) }

  it "should have default avatar" do
    user = build(:user)
    user.avatar.url.should == "https://s3.amazonaws.com/images-hyra/user_default.png"
  end

  it "should have default profile_background_avatar" do
    user = build(:user)
    user.profile_background_avatar.url.should == "https://s3.amazonaws.com/images-hyra/background_default.jpg"
  end

  it "should have the right path for avatar and profile_background_avatarqq" do
    user = create(:user,
                  avatar_file_name: 'ngc.png',
                  avatar_content_type: 'image/png',
                  avatar_file_size: 1024,
                  profile_background_avatar_file_name: 'background.png',
                  profile_background_avatar_content_type: 'image/png',
                  profile_background_avatar_file_size: 1024 )
    user.avatar_file_size.should == 1024

    user.avatar.url.should == "/system/users/avatars/000/000/001/original/ngc.png"
    user.avatar(:thumb).should == "/system/users/avatars/000/000/001/thumb/ngc.png"

  end
=end
end