# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instruction do
    lecture nil
    payload '{"myKey": "myVal"}'
  end
end
