FactoryGirl.define do
  factory :user do
    sequence(:name)         { |n| "TestUser.#{Time.now.to_i}.#{n}" }
    password                "TestPass"
    password_confirmation   "TestPass"
  end
end
