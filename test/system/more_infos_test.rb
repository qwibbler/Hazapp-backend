require 'application_system_test_case'

class MoreInfosTest < ApplicationSystemTestCase
  setup do
    @more_info = more_infos(:one)
  end

  test 'visiting the index' do
    visit more_infos_url
    assert_selector 'h1', text: 'More infos'
  end

  test 'should create more info' do
    visit more_infos_url
    click_on 'New more info'

    click_on 'Create More info'

    assert_text 'More info was successfully created'
    click_on 'Back'
  end

  test 'should update More info' do
    visit more_info_url(@more_info)
    click_on 'Edit this more info', match: :first

    click_on 'Update More info'

    assert_text 'More info was successfully updated'
    click_on 'Back'
  end

  test 'should destroy More info' do
    visit more_info_url(@more_info)
    click_on 'Destroy this more info', match: :first

    assert_text 'More info was successfully destroyed'
  end
end
