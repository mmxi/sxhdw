class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  
  validates :email, :email_format => true
  validates_length_of :email, :within => 3..20, :on => :create, :message => "must be present"
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_confirmation_of :password
  
  
  has_many :authorizations, :dependent => :destroy
  has_many :activities, :order => "updated_at desc"
  
  def name
    self.nickname||self.email
  end
  
  acts_as_authentic do |c|
    c.login_field = :email
  end
  
  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  def role_symbols
    @role_symbols ||= (roles || []).map {|r| r.to_sym}
  end
  # End of declarative_authorization code
  
  def self.create_from_hash(hash)
    user = User.new(:nickname => hash['user_info']['name'])
    user.save(false) #create the user without performing validations. This is because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end
end
