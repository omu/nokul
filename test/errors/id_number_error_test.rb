# frozen_string_literal: true

require 'test_helper'

class IdNumberErrorTest < ActiveSupport::TestCase
  test "ID number throws an error message when raised" do
    assert_equal IdNumberError.new.message, 'Geçersiz T.C. Kimlik Numarası'
    I18n.locale = 'en'
    assert_equal IdNumberError.new.message, 'Invalid ID Number'
    I18n.locale = I18n.default_locale
  end
end
