require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "Sports")  
  end
   
  test "should get categories index" do
    # Get the index page via HTTP request
    get :index
    # Check if the response was successful
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  # For this test on Show be able to pass, it has to know the id of the category which it is 
  # trying to show.
  test "should get show" do
    # Here i am getting the id from category
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
end