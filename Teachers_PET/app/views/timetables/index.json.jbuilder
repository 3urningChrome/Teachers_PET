json.array!(@timetables) do |timetable|
  json.extract! timetable, :id, :user_id, :year_start, :year_end, :name, :school
  json.url timetable_url(timetable, format: :json)
end
