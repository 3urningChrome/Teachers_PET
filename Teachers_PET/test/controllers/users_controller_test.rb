require 'test_helper'
require 'clearance/test_unit'

class UsersControllerTest < ActionController::TestCase
    test "User name appears on signup" do
        get :new
        assert_select "form input" do
            assert_select "[id=?]", "user_name" 
        end
    end
end
