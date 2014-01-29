FactoryGirl.define do
  factory :user, aliases: [:teacher, :student] do
    sequence(:name)         { |n| "TestUser.#{Time.now.to_i}.#{n}" }
    password                "TestPass"
    password_confirmation   "TestPass"
    class_rooms 						{ create_list :class_room, 1 }
		role										"student"
    sequence(:token)        { |n| "random.secret.#{Time.now.to_i}.#{n}" }
  end
end
