require "test_helper"

class MaslasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @masla = maslas(:one)
  end

  test "should get index" do
    get maslas_url
    assert_response :success
  end

  test "should get new" do
    get new_masla_url
    assert_response :success
  end

  test "should create masla" do
    assert_difference("Masla.count") do
      post maslas_url, params: { masla: {  } }
    end

    assert_redirected_to masla_url(Masla.last)
  end

  test "should show masla" do
    get masla_url(@masla)
    assert_response :success
  end

  test "should get edit" do
    get edit_masla_url(@masla)
    assert_response :success
  end

  test "should update masla" do
    patch masla_url(@masla), params: { masla: {  } }
    assert_redirected_to masla_url(@masla)
  end

  test "should destroy masla" do
    assert_difference("Masla.count", -1) do
      delete masla_url(@masla)
    end

    assert_redirected_to maslas_url
  end
end
