# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tablet do
    device_id "MyString"
    device_tag "MyString"
    token "MyString"
    user nil
    content ""
  end
end
