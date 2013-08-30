# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    teacher nil
    class_room nil
    name "MyString"
    start_time "2013-08-30 16:00:03"
  end
end
