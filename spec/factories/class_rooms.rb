# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_room do
    standard "MyString"
    section "MyString"
    school
    courses  { create_list :course, 2 }
  end
end
