# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
      name "MyString"
      host "MyString"
      topics_count 0
      posts_count 0
      description "MyText"
    end
end