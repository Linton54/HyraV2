FactoryGirl.define do
  #factory :relationship do |r|
    #r.user_id { rand(1..1000) }
    #r.followed_id { rand(1001..2000) }
  #end

  #factory :post do |p|
    #user
    #p.title { Faker::Book.title }
    #p.content { Faker::Lorem.paragraph(rand(5..20)) }
  #end

  factory :user do |f|

    f.username { Faker::Lorem.characters(6) + rand(0..10).to_s }
    f.email { Faker::Internet.safe_email(username) }
    f.password { "password" }
    f.password_confirmation { "password" }

    #factory :user_with_posts do
      #transient do
        #posts_count 2
      #end

      #after(:create) do |user, evaluator|
        #create_list(:post, evaluator.posts_count, user: user)
      #end
    #end
  end
end