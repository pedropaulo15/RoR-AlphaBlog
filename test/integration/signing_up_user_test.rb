require 'test_helper'

class SigninUpUser < ActionDispatch::IntegrationTest
  
  test "Should Sign Up User" do
    get signup_path
    assert_template 'users/new'
    assert_response :success
    
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "IntegrationTest", email: "integration@test.com", password: "password"}
      assert_response :success
    end
    
    assert_template "users/show"
    assert_match "IntegrationTest", response.body 
  end
  
end