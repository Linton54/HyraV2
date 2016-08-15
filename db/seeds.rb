require 'factory_girl_rails'

user1 = FactoryGirl.create(:user, username: "Marv", email: "dadda@yahoo.com")
user2 = FactoryGirl.create(:user, username: "Juriz", email: "juriz@yahoo.com")
user3 = FactoryGirl.create(:user, username: "Zyzz", email: "zyzz@yahoo.com")

user1.confirm
user2.confirm
user3.confirm

20.times do
  FactoryGirl.create(:user)
end