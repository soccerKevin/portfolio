require "test_helper"

class BlogEntriesControllerTest < ActionController::TestCase

  def blog_entry
    @blog_entry ||= blog_entries :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_entries)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('BlogEntry.count') do
      post :create, blog_entry: { content: blog_entry.content, name: blog_entry.name, title: blog_entry.title }
    end

    assert_redirected_to blog_entry_path(assigns(:blog_entry))
  end

  def test_show
    get :show, id: blog_entry
    assert_response :success
  end

  def test_edit
    get :edit, id: blog_entry
    assert_response :success
  end

  def test_update
    put :update, id: blog_entry, blog_entry: { content: blog_entry.content, name: blog_entry.name, title: blog_entry.title }
    assert_redirected_to blog_entry_path(assigns(:blog_entry))
  end

  def test_destroy
    assert_difference('BlogEntry.count', -1) do
      delete :destroy, id: blog_entry
    end

    assert_redirected_to blog_entries_path
  end
end
