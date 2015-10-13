json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :name, :start_date, :end_date, :timetable_id
  json.url holiday_url(holiday, format: :json)
end
