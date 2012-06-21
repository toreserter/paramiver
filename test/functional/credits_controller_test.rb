require 'test_helper'

class CreditsControllerTest < ActionController::TestCase
  setup do
    @credit = credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create credit" do
    assert_difference('Credit.count') do
      post :create, credit: { durum: @credit.durum, friend_id: @credit.friend_id, miktar: @credit.miktar, not: @credit.not, vade_tarih: @credit.vade_tarih, ver_tarih: @credit.ver_tarih }
    end

    assert_redirected_to credit_path(assigns(:credit))
  end

  test "should show credit" do
    get :show, id: @credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @credit
    assert_response :success
  end

  test "should update credit" do
    put :update, id: @credit, credit: { durum: @credit.durum, friend_id: @credit.friend_id, miktar: @credit.miktar, not: @credit.not, vade_tarih: @credit.vade_tarih, ver_tarih: @credit.ver_tarih }
    assert_redirected_to credit_path(assigns(:credit))
  end

  test "should destroy credit" do
    assert_difference('Credit.count', -1) do
      delete :destroy, id: @credit
    end

    assert_redirected_to credits_path
  end
end
