class AddSelectedTimetableIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :selected_timetable_id, :integer
  end
end
