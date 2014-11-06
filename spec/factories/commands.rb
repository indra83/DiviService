# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :command do
    student nil
    class_room nil
    teacher
    course nil
    book nil
    item_code "MyString"
    item_category "MyString"
    status "MyString"
    data nil
    applied_at ""
    ends_at "2014-02-26 00:40:23"
  end
end
