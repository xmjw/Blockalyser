require 'test_helper'

class ImageControllerTest < ActionController::TestCase
  test "should get upload" do
    get :upload
    assert_response :success
  end

  test "should get render" do
    get :render
    assert_response :success
  end

end
