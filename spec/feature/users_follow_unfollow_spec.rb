require 'rails_helper'

feature "UserFollowUnfollow", type: [:feature, :userhelper, :request] do


  scenario "Follow and Unfollow User" do
    marv = create(:user)
    juriz = create(:user)

    visit new_user_session_path
    marv.confirm #confirm email address
    log_in(marv)
    expect(page).to have_current_path(root_path)
    click_link("Profile")
    find_link('Edit Profile').visible?
    expect(page).to have_content "#{marv.username}"
    expect(page).to have_selector('user-following', count: 0)
    expect(marv.following.size).to eq(0)
    visit user_path(juriz.username)
    expect(juriz.followers.size).to eq(0)
    find_button('Follow').visible?
    #follow juriz
    click_button("Follow")
    marv.following.reload
    juriz.followers.reload
    expect(marv.following.size).to eq(1)
    expect(juriz.followers.size).to eq(1)
  end
end