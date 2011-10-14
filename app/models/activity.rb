class Activity < ActiveRecord::Base
  acts_as_taggable
  validates_presence_of :act_subject, :act_place
  
  has_one :act_text
  accepts_nested_attributes_for :act_text
  belongs_to :user
  has_many :sns_activity_users
  has_many :sns_users, :through => :sns_activity_users, :source => :user
  
  def interest_users
    @sns_join_users = User.find(:all, :joins => :sns_activity_users, :conditions => ["sns_activity_users.activity_id = ? AND sns_activity_users.interest = ?", self.id, true])
  end
  
  def join_users
    @sns_join_users = User.find(:all, :joins => :sns_activity_users, :conditions => ["sns_activity_users.activity_id = ? AND sns_activity_users.attendee = ?", self.id, true])
  end

end
