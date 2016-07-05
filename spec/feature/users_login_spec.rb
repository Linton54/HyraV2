require 'rails_helper'

feature "UsersLogin", type: [:feature, :userhelper, :request] do

  let(:user) { create(:user) }

  scenario "login with invalid information" do
    visit new_user_session_path
    expect(page).to have_current_path(new_user_session_path)
    fill_in "user_email", with: ""
    fill_in "user_password", with: ""
    click_button "Log in"
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "login with valid information followed by logout" do
    visit new_user_session_path
    user.confirm
    log_in(user)
    expect(page).to have_current_path(root_path)
    find_link('Write to Humanity').visible?
    find_link('Profile').visible?
    find_link('Signout').visible?
    expect(page).to have_content('Signed in successfully')
    sign_out
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_current_path(new_user_session_path)
  end
end