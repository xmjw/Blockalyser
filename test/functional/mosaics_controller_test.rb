require 'test_helper'

class MosaicsControllerTest < ActionController::TestCase
  setup do
    @mosaic = mosaics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mosaics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mosaic" do
    assert_difference('Mosaic.count') do
      post :create, :mosaic => @mosaic.attributes
    end

    assert_redirected_to mosaic_path(assigns(:mosaic))
  end

  test "should show mosaic" do
    get :show, :id => @mosaic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mosaic.to_param
    assert_response :success
  end

  test "should update mosaic" do
    put :update, :id => @mosaic.to_param, :mosaic => @mosaic.attributes
    assert_redirected_to mosaic_path(assigns(:mosaic))
  end

  test "should destroy mosaic" do
    assert_difference('Mosaic.count', -1) do
      delete :destroy, :id => @mosaic.to_param
    end

    assert_redirected_to mosaics_path
  end
end
