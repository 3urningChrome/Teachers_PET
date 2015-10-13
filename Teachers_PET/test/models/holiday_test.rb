require 'test_helper'

class HolidayTest < ActiveSupport::TestCase
  test "the Holiday requires a timetable_id" do
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: Date.tomorrow).invalid?
  end
  
  test "the Holiday's name is not allowed to be blank" do
    assert Holiday.new(name: "", start_date: Date.today, end_date: Date.tomorrow, timetable_id: 1).invalid?
  end
  
  test "the Holiday has a valid start_date" do
    assert Holiday.new(name: "test1", start_date: "", end_date: Date.tomorrow, timetable_id: 1).invalid?, 1
    assert Holiday.new(name: "test1", end_date: Date.tomorrow, timetable_id: 1).invalid?, 2
    assert Holiday.new(name: "test1", start_date: "bob", end_date: Date.tomorrow, timetable_id: 1).invalid? , 3
  end
  
  test "the Holiday has a valid end_date" do
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: "", timetable_id: 1).invalid?,1
    assert Holiday.new(name: "test1", start_date: Date.today, timetable_id: 1).invalid?,2
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: "bob", timetable_id: 1).invalid?,3
  end  
  
  test "the Holiday is valid only when it's start_date is before it's end_date" do
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: Date.tomorrow, timetable_id: 1).valid?, 1
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: Date.yesterday, timetable_id: 1).invalid?, 2
    assert Holiday.new(name: "test1", start_date: Date.today, end_date: Date.today, timetable_id: 1).invalid?, 3
    
  end
end
