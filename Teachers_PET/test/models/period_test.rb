require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  test "the Period requires a timetable_id" do
    assert Period.new(name: "test1", start_time: Time.now, end_time: Time.now).invalid?
  end
  
  test "the Period's name is not allowed to be blank" do
    assert Period.new(name: "", start_time: Time.now, end_time: Time.now, timetable_id: 1).invalid?
  end
  
  test "the Period has a valid start_time" do
    assert Period.new(name: "test1", start_time: "", end_time: Time.now, timetable_id: 1).invalid?, 1
    assert Period.new(name: "test1", end_time: Time.now, timetable_id: 1).invalid? , 2
    assert Period.new(name: "test1", start_time: "bob", end_time: Time.now, timetable_id: 1).invalid? , 3
  end
  
  test "the Period has a valid end_time" do
    assert Period.new(name: "test1", start_time: Time.now, end_time: "", timetable_id: 1).invalid?
    assert Period.new(name: "test1", start_time: Time.now, timetable_id: 1).invalid?
    assert Period.new(name: "test1", start_time: Time.now, end_time: "bob", timetable_id: 1).invalid?
  end  
  
  test "the Period is valid only when it's start_time is before it's end_time" do
    assert Period.new(name: "test1", start_time: 1.minute.ago, end_time: Time.now, timetable_id: 1).valid?, 1
    assert Period.new(name: "test1", start_time: Time.now, end_time: 1.minute.ago, timetable_id: 1).invalid?, 2
    t = Time.now
    assert Period.new(name: "test1", start_time: t, end_time: t, timetable_id: 1).invalid?, 3
    
  end
end
