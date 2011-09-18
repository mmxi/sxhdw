class UserSession < Authlogic::Session::Base
  
  remember_me_for 2.minutes
  
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end