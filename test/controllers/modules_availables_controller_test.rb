require 'test_helper'

class ModulesAvailablesControllerTest < ActionController::TestCase
  setup do
    @modules_available = modules_availables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modules_availables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modules_available" do
    assert_difference('ModulesAvailable.count') do
      post :create, modules_available: { account: @modules_available.account, aleks: @modules_available.aleks, bookadvance: @modules_available.bookadvance, communication: @modules_available.communication, deposit: @modules_available.deposit, emergency: @modules_available.emergency, faualert: @modules_available.faualert, finaid: @modules_available.finaid, housingfee: @modules_available.housingfee, housingmealplan: @modules_available.housingmealplan, immunization: @modules_available.immunization, learning_comm: @modules_available.learning_comm, netid: @modules_available.netid, oars: @modules_available.oars, orientation: @modules_available.orientation, owlcard: @modules_available.owlcard, registration: @modules_available.registration, residency: @modules_available.residency, tution: @modules_available.tution, vehiclereg: @modules_available.vehiclereg, welcome: @modules_available.welcome, znumber: @modules_available.znumber }
    end

    assert_redirected_to modules_available_path(assigns(:modules_available))
  end

  test "should show modules_available" do
    get :show, id: @modules_available
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modules_available
    assert_response :success
  end

  test "should update modules_available" do
    patch :update, id: @modules_available, modules_available: { account: @modules_available.account, aleks: @modules_available.aleks, bookadvance: @modules_available.bookadvance, communication: @modules_available.communication, deposit: @modules_available.deposit, emergency: @modules_available.emergency, faualert: @modules_available.faualert, finaid: @modules_available.finaid, housingfee: @modules_available.housingfee, housingmealplan: @modules_available.housingmealplan, immunization: @modules_available.immunization, learning_comm: @modules_available.learning_comm, netid: @modules_available.netid, oars: @modules_available.oars, orientation: @modules_available.orientation, owlcard: @modules_available.owlcard, registration: @modules_available.registration, residency: @modules_available.residency, tution: @modules_available.tution, vehiclereg: @modules_available.vehiclereg, welcome: @modules_available.welcome, znumber: @modules_available.znumber }
    assert_redirected_to modules_available_path(assigns(:modules_available))
  end

  test "should destroy modules_available" do
    assert_difference('ModulesAvailable.count', -1) do
      delete :destroy, id: @modules_available
    end

    assert_redirected_to modules_availables_path
  end
end
