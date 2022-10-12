require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = Article.create(title: "Article to be test", description: "Description of the article to be test, automatically", user_id: 5)
  end

  test "should get index" do
    get articles_path
    assert_response :success
  end

  test "should get new" do
    get new_article_path
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count", 1) do
      post articles_path, params: { article: { description: "The description of the article to be test automatically", title: "The title of the article to be test", user_id: 4 } }
    end

    assert_redirected_to article_path(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_path(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_path(@article), params: { article: { description: "Article is updated automatically", title: "Updated - Description of the article to be test, automatically" } }
    assert_redirected_to article_path(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_path(@article)
    end

    assert_redirected_to articles_path(@article)
  end
end
