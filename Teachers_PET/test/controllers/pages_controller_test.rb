require 'test_helper'
require 'clearance/test_unit'

# Remember:
# '#id'
# '.class_attribute'
# 'element_name'

class PagesControllerTest < ActionController::TestCase
  
  #Not logged in 
  test "not logged in should redirect from home to signin" do
    get :home_page
    assert_redirected_to "/sign_in"
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "users not logged in should be able to log in" do
    get :index
    assert_select 'a', 'Sign in'    
  end
  
  test "users not logged in should be able to sign up" do
    get :index
    assert_select "form input" do
      assert_select "[value=?]", 'Sign up' 
    end
  end  

  
  #Logged in Users
  test "logged in user should get to home_page" do
    sign_in_as(User.first)
    get :home_page
    assert_response :success
  end

  
  test "logged in user should be able to log out" do
    sign_in_as(User.first)
    get :home_page
    assert_select 'a', 'Sign out'
  end
  
    test "logged in user should be able to go to settings" do
    sign_in_as(User.first)
    get :home_page
    assert_select 'a', 'Settings'
  end
  
  test "logged in user should see timetable selection" do
    sign_in_as(User.first)
    get :home_page
    assert_select "form" do
      assert_select "[id=?]", 'set_timetable'
    end
  end
end 