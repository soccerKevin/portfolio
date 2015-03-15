require "test_helper"

class AuthenticatesControllerTest < ActionController::TestCase

  def authenticate
    @authenticate ||= authenticates :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:authenticates)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Authenticate.count') do
      post :create, authenticate: { name: authenticate.name, password: authenticate.password, password_confirmation: authenticate.password_confirmation }
    end

    assert_redirected_to authenticate_path(assigns(:authenticate))
  end

  def test_show
    get :show, id: authenticate
    assert_response :success
  end

  def test_edit
    get :edit, id: authenticate
    assert_response :success
  end

  def test_update
    put :update, id: authenticate, authenticate: { name: authenticate.name, password: authenticate.password, password_confirmation: authenticate.password_confirmation }
    assert_redirected_to authenticate_path(assigns(:authenticate))
  end

  def test_destroy
    assert_difference('Authenticate.count', -1) do
      delete :destroy, id: authenticate
    end

    assert_redirected_to authenticates_path
  end
end
