require 'application_system_test_case'

class MaslasTest < ApplicationSystemTestCase
  setup do
    @masla = maslas(:one)
  end

  test 'visiting the index' do
    visit maslas_url
    assert_selector 'h1', text: 'Maslas'
  end

  test 'should create masla' do
    visit maslas_url
    click_on 'New masla'

    click_on 'Create Masla'

    assert_text 'Masla was successfully created'
    click_on 'Back'
  end

  test 'should update Masla' do
    visit masla_url(@masla)
    click_on 'Edit this masla', match: :first

    click_on 'Update Masla'

    assert_text 'Masla was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Masla' do
    visit masla_url(@masla)
    click_on 'Destroy this masla', match: :first

    assert_text 'Masla was successfully destroyed'
  end
end
