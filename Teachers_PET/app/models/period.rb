class Period < ActiveRecord::Base
    belongs_to :timetable
    
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :timetable_id, presence: true
    
    validate :start_time_must_be_before_end_time
    
    def start_time_display
        apply_time_formatting read_attribute(:start_time)
    end
    
    def end_time_display
        apply_time_formatting read_attribute(:end_time)
    end
    
    private
    
    def apply_time_formatting(the_time)
        the_time.strftime("%H:%M")
    end
    
    def start_time_must_be_before_end_time
        if !self.start_time.nil? && !self.end_time.nil? then
            errors[:base] << "end time must be after start time" unless self.end_time > self.start_time
        end
    end
end
