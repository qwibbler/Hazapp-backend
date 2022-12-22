require 'application_system_test_case'

class PreMaslasTest < ApplicationSystemTestCase
  setup do
    @pre_masla = pre_maslas(:one)
  end

  test 'visiting the index' do
    visit pre_maslas_url
    assert_selector 'h1', text: 'Pre maslas'
  end

  test 'should create pre masla' do
    visit pre_maslas_url
    click_on 'New pre masla'

    click_on 'Create Pre masla'

    assert_text 'Pre masla was successfully created'
    click_on 'Back'
  end

  test 'should update Pre masla' do
    visit pre_masla_url(@pre_masla)
    click_on 'Edit this pre masla', match: :first

    click_on 'Update Pre masla'

    assert_text 'Pre masla was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Pre masla' do
    visit pre_masla_url(@pre_masla)
    click_on 'Destroy this pre masla', match: :first

    assert_text 'Pre masla was successfully destroyed'
  end
end
