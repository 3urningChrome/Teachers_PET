require 'test_helper'

class PeriodsControllerTest < ActionController::TestCase
  setup do
    @period = periods(:one)
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
    assert_no_difference('Period.count') do
       post :create, period: { end_time: @period.end_time, name: @period.name, start_time: @period.start_time, timetable_id: @period.timetable_id }
    end
  end
  
  test "show should get signin if not logged in" do
    get :show, id: @period
    assert_redirected_to "/sign_in"
  end

  test "edit should get signin if not logged in" do
    get :edit, id: @period
    assert_redirected_to "/sign_in"
  end

  test "should not update period" do
    patch :update, id: @period, period: { end_time: @period.end_time, name: 1, start_time: @period.start_time, timetable_id: @period.timetable_id }
    assert_redirected_to "/sign_in"
    updated_period = Period.find(@period.id)
    assert updated_period.name.eql?(@period.name), updated_period.name #i.e. the save should not have worked    
  end

  test "should not destroy period if not logged in" do
    assert_no_difference('Period.count', -1) do
      delete :destroy, id: Period.first.id
    end

    assert_redirected_to "/sign_in"
  end  
   
  test "should get index" do
    user = User.first
    sign_in_as(user)
    user.selected_timetable_id = Timetable.first.id
    get :index
    assert_response :success
    assert_not_nil assigns(:periods)
  end

  test "should get new" do
    sign_in_as(User.first)
    get :new
    assert_response :success
  end

  test "should create period" do
    user = User.first
    timetable = Timetable.first
    user.selected_timetable_id = timetable.id
    user.save!
    sign_in_as(user)
    assert_difference('Period.count') do
      post :create, period: { end_time: @period.end_time, name: @period.name, start_time: @period.start_time, timetable_id: @period.timetable_id }
    end

    assert_redirected_to settings_path
  end

  test "should show period" do
    sign_in_as(User.first)
    get :show, id: @period
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(User.first)
    get :edit, id: @period
    assert_response :success
  end

  test "should update period" do
    sign_in_as(User.first)
    patch :update, id: @period, period: { end_time: @period.end_time, name: @period.name, start_time: @period.start_time, timetable_id: @period.timetable_id }
    assert_redirected_to settings_path
  end

  test "should destroy period" do
    sign_in_as(User.first)
    assert_difference('Period.count', -1) do
      delete :destroy, id: @period
    end
    assert_redirected_to periods_path
  end
end
