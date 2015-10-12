class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :user_id
      t.date :year_start
      t.date :year_end
      t.string :name
      t.string :school

      t.timestamps null: false
    end
  end
end
