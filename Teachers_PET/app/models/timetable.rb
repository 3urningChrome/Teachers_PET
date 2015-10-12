class Timetable < ActiveRecord::Base
    belongs_to :user
    
    validates :user_id, presence: true 
    validates :year_start, presence: true
    validates :year_end, presence: true
    validate :year_start_before_year_end
    validates :name, presence: true
    
    after_initialize :setup_defaults
    before_validation :set_default_dates_if_blank
    before_validation :set_default_name_if_blank
    before_destroy :do_not_delete_if_last_timetable_on_user

    
    
    private
    
    def setup_defaults
        set_default_dates_if_blank
        set_default_name_if_blank
    end
    
    def set_default_dates_if_blank
        self.year_start = Date.today if self.year_start.nil?
        self.year_end = Date.tomorrow if self.year_end.nil?
    end
    
    def year_start_before_year_end
        # we'll allow same date for now.
        errors[:base] << "year end cannot be earlier than year start" if self.year_end < self.year_start
    end
    
    def set_default_name_if_blank
        self.name = "<Name me>" if self.name.blank?
    end
    
    def do_not_delete_if_last_timetable_on_user
        return false if User.find(self.user_id).timetables.count == 1
    end    
end
