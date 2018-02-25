require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  # Simulating a user interaction
  
  def setup
    @category = Category.create(name: "Books")
    @category2 = Category.create(name: "Programming")
  end
  
  test "Should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    # Selecing a link, and make sure the link is to the category path
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end