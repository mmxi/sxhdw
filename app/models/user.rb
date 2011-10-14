class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # configuration for email
    c.validates_length_of_email_field_options = {:in => 6..100, :too_short => "电子邮件地址太短，看起来不像是正确的"}
    c.validates_format_of_email_field_options = {:with => Authlogic::Regex.email, :message => "电子邮件格式不正确"}
    c.validates_uniqueness_of_email_field_options = {:message => "该电子邮件地址已经被注册"}
    # configuration for login
    c.validates_format_of_login_field_options = {:with => Authlogic::Regex.login, :message =>"名字格式不正确"}
    c.validates_length_of_login_field_options = {:in => 4..32, :too_short => "名字长度最小4个字符", :too_long => "名字长度最长32个字符"}
    c.validates_uniqueness_of_login_field_options = {:message => "该名字已经被注册，请选用其他名字"}
    # configuration for password
    c.validates_confirmation_of_password_field_options = {:on => :create, :message => "两次密码输入不一致，请重新输入"}
    c.validates_length_of_password_field_options = {:on => :create, :in => 6..32, :too_short => "密码长度最小6个字符", :too_long => "密码长度电大32个字符"}
    #c.ignore_blank_passwords = true
    #c.validate_password_field = false
    c.logged_in_timeout 30.minutes
  end

  validates_attachment_size :photo, :less_than => 100.kilobytes, :message => "图片尺寸大小应小于100KB"
  validates_attachment_content_type :photo,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "请选择图片类型文件"
  
  has_many :authorizations, :dependent => :destroy
  has_many :activities, :order => "updated_at desc"
  has_many :sns_activity_users
  has_many :sns_activities, :through => :sns_activity_users, :source => :activity

  attr_accessor :password_confirmation
  attr_accessible :login, :email, :nickname, :password, :password_confirmation, :active, :photo
  attr_protected :active
  has_attached_file :photo, :styles => {:normal => "180x180#", :s120 => "120x120#", :s48 => "48x48#", :s32 => "32x32#", :s24 => "24x24#" }, :url => "/upload/:class/:attachment/:hashed_path/:id_:style.:extension", :path => ":rails_root/public/upload/:class/:attachment/:hashed_path/:id_:style.:extension"

  def activate!
    self.active = true
    save
  end
  
  def display_name
    if self.nickname.blank?
      self.login
    else
      self.nickname
    end
  end

  def self.find_by_login_or_email(login)
     find_by_login(login) || find_by_email(login)
  end

  def self.create_from_hash(hash)
    user = User.new(:nickname => hash['user_info']['name'])
    user.save(false)
    user.reset_persistence_token!
    user
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_welcome!
    reset_perishable_token!
    Notifier.deliver_welcome(self)
  end
end
