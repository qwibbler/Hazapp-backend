require "test_helper"

class PreMaslasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pre_masla = pre_maslas(:one)
  end

  test "should get index" do
    get pre_maslas_url
    assert_response :success
  end

  test "should get new" do
    get new_pre_masla_url
    assert_response :success
  end

  test "should create pre_masla" do
    assert_difference("PreMasla.count") do
      post pre_maslas_url, params: { pre_masla: {  } }
    end

    assert_redirected_to pre_masla_url(PreMasla.last)
  end

  test "should show pre_masla" do
    get pre_masla_url(@pre_masla)
    assert_response :success
  end

  test "should get edit" do
    get edit_pre_masla_url(@pre_masla)
    assert_response :success
  end

  test "should update pre_masla" do
    patch pre_masla_url(@pre_masla), params: { pre_masla: {  } }
    assert_redirected_to pre_masla_url(@pre_masla)
  end

  test "should destroy pre_masla" do
    assert_difference("PreMasla.count", -1) do
      delete pre_masla_url(@pre_masla)
    end

    assert_redirected_to pre_maslas_url
  end
end
