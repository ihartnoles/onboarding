require 'test_helper'

class HousingZipcodesControllerTest < ActionController::TestCase
  setup do
    @housing_zipcode = housing_zipcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:housing_zipcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create housing_zipcode" do
    assert_difference('HousingZipcode.count') do
      post :create, housing_zipcode: { campus: @housing_zipcode.campus, city: @housing_zipcode.city, county: @housing_zipcode.county, distance: @housing_zipcode.distance, state: @housing_zipcode.state, zip: @housing_zipcode.zip }
    end

    assert_redirected_to housing_zipcode_path(assigns(:housing_zipcode))
  end

  test "should show housing_zipcode" do
    get :show, id: @housing_zipcode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @housing_zipcode
    assert_response :success
  end

  test "should update housing_zipcode" do
    patch :update, id: @housing_zipcode, housing_zipcode: { campus: @housing_zipcode.campus, city: @housing_zipcode.city, county: @housing_zipcode.county, distance: @housing_zipcode.distance, state: @housing_zipcode.state, zip: @housing_zipcode.zip }
    assert_redirected_to housing_zipcode_path(assigns(:housing_zipcode))
  end

  test "should destroy housing_zipcode" do
    assert_difference('HousingZipcode.count', -1) do
      delete :destroy, id: @housing_zipcode
    end

    assert_redirected_to housing_zipcodes_path
  end
end
