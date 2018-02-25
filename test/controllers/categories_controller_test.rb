require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "Sports")
    @user = User.create(username: "jhon", email: "jhon@email.com", password: "password", admin: true)
  end
   
  test "should get categories index" do
    # Get the index page via HTTP request
    get :index
    # Check if the response was successful
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user.id
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
  
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: {name: 'Sports' }
    end
    assert_redirected_to categories_path
  end
  
end