# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attempt do
    user
    book
    assessment_id '1'
    sequence(:question_id, &:to_s)
    total_points 1
    attempts 1
    data ""
    last_updated_at "2013-10-28 00:19:27"
  end
end
