require 'test_helper'

class HolidaysControllerTest < ActionController::TestCase
  setup do
    @holiday = holidays(:one)
  end

  test "should get index" do
    user = User.first
    sign_in_as(user)
    user.selected_timetable_id = Timetable.first.id
    get :index
    assert_response :success
    assert_not_nil assigns(:holidays)
  end

  test "should get new" do
    sign_in_as(User.first)
    get :new
    assert_response :success
  end

  test "should create holiday" do
    user = User.first
    timetable = Timetable.first
    user.selected_timetable_id = timetable.id
    user.save!
    sign_in_as(User.first)
    assert_difference('Holiday.count') do
      post :create, holiday: { end_date: @holiday.end_date, name: @holiday.name, start_date: @holiday.start_date, timetable_id: @holiday.timetable_id }
    end

    assert_redirected_to settings_path
  end

  test "should show holiday" do
    sign_in_as(User.first)
    get :show, id: @holiday
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(User.first)
    get :edit, id: @holiday
    assert_response :success
  end

  test "should update holiday" do
    sign_in_as(User.first)
    patch :update, id: @holiday, holiday: { end_date: @holiday.end_date, name: @holiday.name, start_date: @holiday.start_date, timetable_id: @holiday.timetable_id }
    assert_redirected_to settings_path
  end

  test "should destroy holiday" do
    sign_in_as(User.first)
    assert_difference('Holiday.count', -1) do
      delete :destroy, id: @holiday
    end

    assert_redirected_to settings_path
  end
end
