FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 {Faker::Internet.email}
    password              { '1a' + Faker::Internet.unique.password(min_length: 6) }
    password_confirmation {password}
  end
end