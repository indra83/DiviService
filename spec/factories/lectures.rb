# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    teacher
    class_room
    name "MyString"
  end
end
