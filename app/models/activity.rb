class Activity < ActiveRecord::Base
  acts_as_taggable
  validates_presence_of :act_subject, :act_place
  
  has_one :act_text
  accepts_nested_attributes_for :act_text
end
