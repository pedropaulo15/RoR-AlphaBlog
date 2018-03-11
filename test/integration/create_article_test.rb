require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = User.create(username: "jhon", email: "jhon@email.com", password: "password", admin: true)
  end
  
  test "Should Create a New Article" do
    
    sign_in_as(@user, "password")
    
    get new_article_path
    assert_template 'articles/new'
    assert_response :success
    
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: { title: "IntegrationTest", description: "integration test body", category_ids: [id:3, id:2, id:3] }
      assert_response :success
    end
    
    assert_template 'articles/show'
    assert_match 'IntegrationTest', response.body
    
  end

end