require 'rails_helper'

feature "UsersSignup", type: [:feature, :userhelper] do

  scenario "Invalid signup information: blank fields" do
    user = build_stubbed(:user, email: "", username: "", password: "", password_confirmation: "")
    before_count = User.count
    sign_up(user)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Username is too short (minimum is 3 characters)")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: invalid email, rest blank fields" do
    user = build_stubbed(:user, email: "mark@yahooco", username: "", password: "", password_confirmation: "")
    before_count = User.count
    sign_up(user)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Username is too short (minimum is 3 characters)")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: valid email, rest blank fields" do
    user = build_stubbed(:user, email: "mark@yahoo.com", username: "", password: "", password_confirmation: "")
    before_count = User.count
    sign_up(user)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Username is too short (minimum is 3 characters)")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: valid email, username, rest blank fields" do
    user = build_stubbed(:user, email: "mark@yahoo.com", username: "markmark", password: "", password_confirmation: "")
    before_count = User.count
    sign_up(user)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Password can't be blank")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: duplicate: email" do
    old = create(:user, email: "mark@yahoo.com")
    new = build_stubbed(:user, email: "mark@yahoo.com")
    before_count = User.count
    sign_up(new)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Email has already been taken")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: duplicate: username" do
    old = create(:user, email: "old@yahoo.com", username: "oldold")
    new = build_stubbed(:user, email: "new@yahoo.com", username: "oldold")
    before_count = User.count
    sign_up(new)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Username has already been taken")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Invalid signup information: duplicate: username and email" do
    old = create(:user, email: "old@yahoo.com", username: "oldold")
    new = build_stubbed(:user, email: "old@yahoo.com", username: "oldold")
    before_count = User.count
    sign_up(new)
    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_content("Username has already been taken")
    expect(page).to have_content("Email has already been taken")
    after_count = User.count
    expect(before_count).to eq(after_count)
  end

  scenario "Valid signup information" do
    user = build_stubbed(:user)
    sign_up(user)
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
    expect(page).to_not have_content("Email can't be blank")
    expect(page).to_not have_content("Password can't be blank")
    expect(page).to_not have_content("Username can't be blank")
    expect(page).to_not have_content("Username is too short (minimum is 3 characters)")
    expect(User.count).to eq(1)
  end
end