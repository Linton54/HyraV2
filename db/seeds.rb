require 'factory_girl_rails'

15.times do
  FactoryGirl.create(:user_with_posts)
end