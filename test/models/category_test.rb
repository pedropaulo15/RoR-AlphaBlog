require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  # This method runs before everyone of my tests.
  # key method
  def setup
    @category = Category.new(name: "sports")
  end
  
  # Testing Syntax
  test "category should be valid" do
    assert @category.valid?
  end
  
  test "name should be present" do
    @category.name = " "
    # assert_not expects a false value, so in this case, the test will pass, as the 
    # category name is null/empty, when its presence is required (check category.rb model file)
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    # Hits the DB first
    @category.save
    # category2 will not be saved into the DB as a sports already exists
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
   @category.name = "aa"
   assert_not @category.valid?
  end
  
end