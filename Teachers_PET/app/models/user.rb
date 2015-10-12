class User < ActiveRecord::Base
  include Clearance::User
  after_create :setup_timetable
  before_validation :set_default_name_if_blank
  
  has_many :timetables, dependent:  :destroy
  
  validates :name, presence: true
  
  private
  def setup_timetable
      #confirm there is no timetable linked to this user (shouldn't be)
      self.timetables.create(name: "<default>") if self.timetables.count
  end
  
  def set_default_name_if_blank
    self.name = "<Name me>" if self.name.blank?
  end
  
end
