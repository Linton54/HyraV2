require 'factory_girl_rails'

20.times do
  FactoryGirl.create(:user_with_posts)
end