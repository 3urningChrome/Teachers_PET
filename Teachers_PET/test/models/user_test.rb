require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "user attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end
  
  test "user is not valid without a unique email" do
    user = User.new(email: users(:one).email, password: "test")
    assert user.invalid?
    assert_equal ["has already been taken"], user.errors[:email]
  end 
  
  test "new users should have timetables" do
    user = User.new(email: "TestNewUserHasTimetable@example.com", password: "test")
    user.save!
    assert user.timetables.count > 0
  end
  
  test "Should not be able to delete the last timetable" do
   User.last.timetables.new(name: "Timetable_test1").save!
   User.last.timetables.destroy
    assert User.last.timetables.count > 0,User.last.timetables.count
  end
  
  test "the user name is never blank" do
    t = User.first
    t.name = ""
    t.save!
    assert_not User.first.name.blank?
  end
end