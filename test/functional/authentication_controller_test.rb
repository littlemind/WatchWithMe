require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get creare" do
    get :creare
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
