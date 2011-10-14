# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sxhdw::Application.initialize!

ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.default :content_type => "text/html"
ActionMailer::Base.smtp_settings = {
  :address => "smtp.163.com",
  :port => "25",
  :authentication => :plain,
  :user_name => "service_170575",
  :password => "fuck4311,."
}