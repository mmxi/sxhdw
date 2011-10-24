# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
      name "film"
      description "MyText"
      topics_count 1
      posts_count 1
    end
end