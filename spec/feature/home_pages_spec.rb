require 'rails_helper'

feature "HomePages", type: [:feature, :userhelper] do

  let(:user) { create(:user_with_posts) }

  scenario "User not log in" do
    visit root_path
    page.assert_selector('a', text: 'Log in')
    page.assert_selector('a', text: 'Sign up', count: 2)
    page.assert_selector('h1.form-logo', text: 'Hyra')
    page.find('input#user_remember_me')
    find_button('Log in')
  end

  scenario "User log in" do
    user.confirm #confirm email address
    log_in(user)
    page.assert_selector('a', text: 'Write a letter')
    page.assert_selector('a', text: 'Profile')
    page.assert_selector('a', text: 'Signout')
  end
end
