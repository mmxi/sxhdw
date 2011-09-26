class ActText < ActiveRecord::Base
  validates_presence_of :act_description
  belongs_to :activity
end