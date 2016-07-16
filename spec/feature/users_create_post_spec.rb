require 'rails_helper'

feature "UserCreatePost", type: [:feature, :userhelper, :request] do

  let(:user) { create(:user) }

  scenario "Create post with invalid information" do
    visit new_user_session_path
    user.confirm #confirm email address
    log_in(user)
    expect(page).to have_current_path(root_path)
    click_link("Write a letter")
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Content'
    expect(page).to have_content 'Category'
    find_button('SEND').visible?
    fill_in 'post_title', with: ''
    fill_in 'post_content', with: ''
    select 'I Love You', from: 'post_category'
    click_button('SEND')
    expect(page).to have_content 'This form contains 4 errors'
  end

  scenario "Create post with valid information" do
    visit new_user_session_path
    user.confirm #confirm email address
    log_in(user)
    expect(page).to have_current_path(root_path)
    click_link("Write a letter")
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Content'
    expect(page).to have_content 'Category'
    find_button('SEND').visible?
    fill_in 'post_title', with: 'Arrow Head'
    fill_in 'post_content', with: 'This the reason why i cant let go of myself, its killing me inside. Im sorry'
    select 'I Love You', from: 'post_category'
    click_button('SEND')
    expect(page).to have_current_path(root_path)
    expect(page).to have_content 'Arrow Head'
  end
end