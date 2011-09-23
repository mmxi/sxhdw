# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zhangsan do
    login "zhangsan"
    nickname  "张三"
    email "cjdx4311@gmail.com"
    password  "123456"
    password_confirmation "123456"
  end
  factory :lisi do
    login "lisi"
    nickname  "李四"
    email "wangliang4311@gmail.com"
    password  "123456"
    password_confirmation "123456"
  end
end