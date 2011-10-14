class UserSession < Authlogic::Session::Base
  
  remember_me_for 2.weeks
  
  find_by_login_method :find_by_login_or_email
  
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end