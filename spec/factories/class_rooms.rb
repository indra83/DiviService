# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_room do
    ignore do
      user false
    end

    standard "MyString"
    section "MyString"
    school

    after(:create) do |class_room, evaluator|
      create :participation, class_room: class_room, user: evaluator.user if evaluator.user
    end
  end
end
