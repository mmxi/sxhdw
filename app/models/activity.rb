class Activity < ActiveRecord::Base
  validates_presence_of :act_subject, :act_place
end
