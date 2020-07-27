# frozen_string_literal: true

require 'test_helper'

class ToastrHelperTest < ActionView::TestCase
  test 'toastr helper' do
    assert_equal('toastr.error', toastr_flash_class('alert'))
    assert_equal('toastr.success', toastr_flash_class('notice'))
    assert_equal('toastr.info', toastr_flash_class('something_else'))
  end
end
