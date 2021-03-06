require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "jhon", email: "jhon@email.com", password: "password", admin: true)
  end
  
  # Simulating a user interaction
  test "get new category form and create category" do
    sign_in_as(@user, "password")
    # Going to a new categoty path
    get new_category_path
    # Getting the form from adding a new category
    assert_template 'categories/new'
    assert_response :success
    # Posting the new form creating this new category "sports"
    assert_difference 'Category.count', 1 do
      # Redirects me to the create action and add a new category by the POST request
      post_via_redirect categories_path, category: {name: "sports"}
    end
    # After beign created, it will redirect to the index page
    assert_template 'categories/index'
    # String inserted displaying on the body page
    assert_match "sports", response.body
  end
  
  # Simulating if an invalid input is actually blocked
  test "Invalid category submission results in failure" do
    
    sign_in_as(@user, "password")
    
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      # inserting a empty string for category name
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    # Checking for h2 and div with those classes in the categories/new body page
    # and makind sure my error messages is being rendered
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end