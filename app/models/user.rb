class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :authorizations, :dependent => :destroy
  
  acts_as_authentic
  
  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  def role_symbols
    @role_symbols ||= (roles || []).map {|r| r.to_sym}
  end
  # End of declarative_authorization code
  
  def self.create_from_hash(hash)
    user = User.new(:login => hash['user_info']['name'])
    user.save(false) #create the user without performing validations. This is because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end
end
