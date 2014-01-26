# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cdn do
    base_url "http://cdn"
    school nil
  end
end
