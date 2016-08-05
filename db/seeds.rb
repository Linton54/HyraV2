require 'factory_girl_rails'

100.times do
  FactoryGirl.create(:user_with_posts)
end