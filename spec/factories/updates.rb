# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    description "MyString"
    book_version 9
    details "MyString"
    file "MyString"
    book
    status "live"
    strategy "replace"
  end
end
