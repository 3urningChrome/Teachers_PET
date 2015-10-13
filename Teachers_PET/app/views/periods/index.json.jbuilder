json.array!(@periods) do |period|
  json.extract! period, :id, :name, :start_time, :end_time, :timetable_id
  json.url period_url(period, format: :json)
end
