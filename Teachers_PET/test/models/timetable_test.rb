require 'test_helper'

class TimetableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "the timetable must always have a user attached" do
    assert Timetable.new(name: "test", year_start: Date.new, year_end: Date.new).invalid?
  end
  
  test "the timetable name is never blank" do
    t = Timetable.first
    t.name = ""
    t.save!
    assert_not Timetable.first.name.blank?
  end
  
  test "the year start can never be blank" do
    t = Timetable.first
    t.year_start = ""
    t.year_end = Date.tomorrow #set so we don't get missleading failures
    t.save!
    assert_not Timetable.first.year_start.blank?
  end
  
  test "the year end can never be blank" do
    t = Timetable.first
    t.year_end = ""
    t.year_start = Date.yesterday #set so we don't get missleading failures
    t.save!
    assert_not Timetable.first.year_end.blank?
  end
  
  test "the year end can never be before the year start" do
    t = Timetable.first
    t.year_end = Date.yesterday
    t.year_start = Date.tomorrow
    assert t.invalid?, t.year_start.to_s + "-" + t.year_end.to_s
  end
  
end
