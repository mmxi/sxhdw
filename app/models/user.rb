class User < ActiveRecord::Base
  acts_as_authentic

  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  def role_symbols
    @role_symbols ||= (roles || []).map {|r| r.to_sym}
  end
  # End of declarative_authorization code
end
