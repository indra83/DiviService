# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    description "MyString"
    version "9.99"
    details "MyString"
    file "MyString"
    book
    status "live"
    strategy "replace"
  end
end
