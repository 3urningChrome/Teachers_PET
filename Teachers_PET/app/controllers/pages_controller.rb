
class PagesController < ApplicationController
  before_action :require_login, only: [:home_page]
  
  def index
  end
  
  def home_page
    
  end
  
  def set_current_timetable
    user = User.find(current_user.id)
    user.selected_timetable_id = params['set_timetable']
    user.save!
    redirect_to root_path
  end
end
