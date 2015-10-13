require 'test_helper'

class TimetablesControllerTest < ActionController::TestCase
  setup do
    @timetable = timetables(:one)
    @timetable.user_id = User.first.id
  end

#NOT LOGGED IN
  test "index should get signin if not logged in" do
    get :index
    assert_redirected_to "/sign_in"
  end
  
  test "new should get signin if not logged in" do
    get :new
    assert_redirected_to "/sign_in"
  end
  
  test "create should get signin if not logged in and not create" do
    assert_no_difference('Timetable.count') do
       post :create, timetable: { name: @timetable.name, school: @timetable.school, user_id: @timetable.user_id, year_end: @timetable.year_end, year_start: @timetable.year_start }
    end
  end
  
  test "show should get signin if not logged in" do
    get :show, id: @timetable
    assert_redirected_to "/sign_in"
  end

  test "edit should get signin if not logged in" do
    get :edit, id: @timetable
    assert_redirected_to "/sign_in"
  end

  test "should not update timetable" do
    patch :update, id: @timetable, timetable: { name: "1", school: @timetable.school, user_id: @timetable.user_id, year_end: @timetable.year_end, year_start: @timetable.year_start }
    assert_redirected_to "/sign_in"
    updated_timetable = Timetable.find(@timetable.id)
    assert updated_timetable.name.eql?(@timetable.name), updated_timetable.name #i.e. the save should not have worked
  end

  test "should not destroy timetable if not logged in" do
    user = User.first
    user.timetables.new(name: "timetable test1").save!
    user.timetables.new(name: "timetable test2").save!
    timetable_id = user.timetables.first
    assert_no_difference('Timetable.count', -1) do
      delete :destroy, id: timetable_id
    end

    assert_redirected_to "/sign_in"
  end  
  
# LOGGED IN
  test "should get index" do
    sign_in_as(User.first)
    get :index
    assert_response :success
    assert_not_nil assigns(:timetables)
  end

  test "should get new" do
    sign_in_as(User.first)
    get :new
    assert_response :success
  end

  test "should create timetable" do
    sign_in_as(User.first)
    assert_difference('Timetable.count') do
      post :create, timetable: { name: @timetable.name, school: @timetable.school, user_id: @timetable.user_id, year_end: @timetable.year_end, year_start: @timetable.year_start }
    end

    assert_redirected_to settings_path
  end

  test "should show timetable" do
    sign_in_as(User.first)
    get :show, id: @timetable
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(User.first)
    get :edit, id: @timetable
    assert_response :success
  end

  test "should update timetable" do
    sign_in_as(User.first)
    patch :update, id: @timetable, timetable: { name: 1, school: @timetable.school, user_id: @timetable.user_id, year_end: @timetable.year_end, year_start: @timetable.year_start }
    assert_redirected_to settings_path
    updated_timetable = Timetable.find(@timetable.id)
    assert_not updated_timetable.name.eql?(@timetable.name), updated_timetable.name #i.e. the save should have worked
  end

  test "should destroy timetable" do
    sign_in_as(User.first)
    #user must have two+ timetables for this to work.
    #as User can never have < 1 timetable.
    user = User.first
    user.timetables.new(name: "timetable test1").save!
    user.timetables.new(name: "timetable test2").save!
    timetable_id = user.timetables.first
    assert_difference('Timetable.count', -1) do
      delete :destroy, id: timetable_id
    end

    assert_redirected_to timetables_path
  end
end
