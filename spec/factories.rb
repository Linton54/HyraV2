FactoryGirl.define do

  factory :message do |m|
    inbox
    m.content { Faker::Lorem.paragraph(rand(1..5)) }
    m.recipient { Faker::Name.first_name }
    m.inbox_id { rand(1..50) }
  end

  factory :inbox do |i|
    i.sender_id { rand(1..1000) }
    i.receiver_id { rand(1001..2000) }

    factory :inbox_with_messages do
      transient do
        messages_count 2
      end

      after(:create) do |inbox, evaluator|
        create_list(:message, evaluator.messages_count, inbox: inbox)
      end
    end

  end

  factory :relationship do |r|
    r.follower_id { rand(1..1000) }
    r.followed_id { rand(1001..2000) }
  end

  factory :post do |p|
    user
    p.title { Faker::Book.title }
    p.content { Faker::Lorem.paragraph(rand(5..20)) }
    category = ["Missing You", "Long Distance", "Heartbreak", "I Love You", "Happiness"]
    p.category { category.sample }
  end

  factory :user do |f|

    f.username { Faker::Lorem.characters(6) + rand(0..10).to_s }
    f.email { Faker::Internet.safe_email(username) }
    f.password { "password" }
    f.password_confirmation { "password" }

    factory :user_with_inboxes do
      transient do
        inboxes_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:inbox, evaluator.inboxes_count, user: user)
      end
    end

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