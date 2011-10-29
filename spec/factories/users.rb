# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zhangsan, :class => User do
    login "zhangsan"
    nickname  "张三"
    email "zhangsan@gmail.com"
    password  "123456"
    password_confirmation "123456"
  end

  factory :lisi, :class => User do
    login "lisi"
    nickname  "李四"
    email "lisi@gmail.com"
    password  "123456"
    password_confirmation "123456"
  end

  factory :wangwu, :class => User do
    login "wangwu"
    email "wangwu@gmail.com"
    password  "123456"
    password_confirmation "123456"
  end

  factory :user, :class => User do
    login "test"
    email "test@163.com"
    password  "123456"
    password_confirmation "123456"
  end
end
