FactoryGirl.define do

  factory :comment do |c|
    c.content { Faker::Lorem.paragraph(rand(1..2)) }
    c.commentable_id { rand(1..50) }
    c.commentable_type { "Post" }
    c.user_id { rand(1..10) }
  end

  factory :relationship do |r|
    r.follower_id { rand(1..1000) }
    r.followed_id { rand(1001..2000) }
  end

  factory :post do |p|
    p.title { Faker::Book.title }
    p.content { Faker::Lorem.paragraph(rand(15..30)) }
    category = ["Love", "Apology", "Thank You", "Farewell"]
    p.category { category.sample }
    p.user_id { rand(1..1000) }
    user
  end

  factory :user do |f|

    f.username { Faker::Lorem.characters(6) + rand(0..10).to_s }
    f.email { Faker::Internet.safe_email(username) }
    f.password { "password" }
    f.password_confirmation { "password" }
    f.confirmed_at Date.today

    factory :user_with_posts do
      transient do
        posts_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end