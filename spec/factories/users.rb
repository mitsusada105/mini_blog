# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.alpha(number: 8) }
    email    { Faker::Internet.email }  # safe_email の代わりに email を利用
    profile  { Faker::Lorem.sentence(word_count: 10) }
    blog_url { Faker::Internet.url }
    password { "password" }
    password_confirmation { "password" }
  end
end
