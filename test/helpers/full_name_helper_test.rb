# frozen_string_literal: true

require 'test_helper'

class FullNameHelperTest < ActionView::TestCase
  test 'full_name can return a full name for academic term' do
    assert_equal('2017 - 2018 / Güz', full_name(academic_terms(:fall_2017_2018)))
  end

  test 'full_name can return a full name for identity' do
    assert_equal('john doe', full_name(identities(:formal_user)))
  end
end
