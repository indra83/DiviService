FactoryGirl.define do
  factory :user, aliases: [:teacher, :student] do
    sequence(:name)         { |n| "TestUser.#{Time.now.to_i}.#{n}" }
    class_rooms 						{ create_list :class_room, 1 }
		role										"student"
    account
  end
end
