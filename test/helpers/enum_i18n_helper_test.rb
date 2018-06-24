# frozen_string_literal: true

require 'test_helper'

class EnumI18nHelperTest < ActionView::TestCase
  test 'enum_options_for_select method' do
    assert_equal enum_options_for_select(Course, :status), [
      ["Pasif", "passive"], ["Aktif", "active"], ["Yürürlükten Kaldırılmış", "abrogated"]
    ]
  end
end
