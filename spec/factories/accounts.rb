# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    password                "TestPass"
    password_confirmation   "TestPass"
    sequence(:token)        { |n| "random.secret.#{Time.now.to_i}.#{n}" }
  end
end
