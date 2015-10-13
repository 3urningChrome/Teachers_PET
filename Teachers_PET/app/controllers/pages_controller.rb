
class PagesController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
  end
  
  def home_page
  end
  
  def settings
    @timetables = current_user.timetables
    @timetable = Timetable.find(current_user.selected_timetable_id)
    @periods = @timetable.periods
    @holidays = @timetable.holidays
  end
  
  def set_current_timetable
    user = User.find(current_user.id)
    user.selected_timetable_id = params['set_timetable']
    user.save!
    redirect_to :back
  end
end
