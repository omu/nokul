# frozen_string_literal: true

require 'test_helper'

class ToastrHelperTest < ActionView::TestCase
  test 'toastr helper' do
    assert_equal toastr_flash_class('alert'), 'toastr.error'
    assert_equal toastr_flash_class('notice'), 'toastr.success'
    assert_equal toastr_flash_class('something_else'), 'toastr.info'
  end
end
