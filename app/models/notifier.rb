# encoding: utf-8
class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "请激活你的帐号，完成注册"
    from          '"绍兴活动网"<service_170575@163.com>'
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => activate_url(user.perishable_token), :username => user.login
  end

  def welcome(user)
    subject       "Welcome to the site!"
    from          '"绍兴活动网"<service_170575@163.com>'
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
end
