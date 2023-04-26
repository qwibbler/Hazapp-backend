require 'test_helper'

class MoreInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @more_info = more_infos(:one)
  end

  test 'should get index' do
    get more_infos_url
    assert_response :success
  end

  test 'should get new' do
    get new_more_info_url
    assert_response :success
  end

  test 'should create more_info' do
    assert_difference('MoreInfo.count') do
      post more_infos_url, params: { more_info: {} }
    end

    assert_redirected_to more_info_url(MoreInfo.last)
  end

  test 'should show more_info' do
    get more_info_url(@more_info)
    assert_response :success
  end

  test 'should get edit' do
    get edit_more_info_url(@more_info)
    assert_response :success
  end

  test 'should update more_info' do
    patch more_info_url(@more_info), params: { more_info: {} }
    assert_redirected_to more_info_url(@more_info)
  end

  test 'should destroy more_info' do
    assert_difference('MoreInfo.count', -1) do
      delete more_info_url(@more_info)
    end

    assert_redirected_to more_infos_url
  end
end
