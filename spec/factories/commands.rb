# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :command do
    user nil
    class_room nil
    teacher nil
    course nil
    book nil
    item_code "MyString"
    item_category "MyString"
    type ""
    status "MyString"
    data ""
    applied_at ""
    ends_at "2014-02-26 00:40:23"
  end
end
