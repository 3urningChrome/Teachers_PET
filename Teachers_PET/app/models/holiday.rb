class Holiday < ActiveRecord::Base
  belongs_to :timetable
  
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :timetable_id, presence: true
  
  validate :start_date_must_be_before_end_date
  
  private
   
  def start_date_must_be_before_end_date
    unless self.start_date.nil? || self.end_date.nil? 
      errors[:base] << "end time must be after start time" unless self.end_date > self.start_date
    end
  end 
end
