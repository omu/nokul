# frozen_string_literal: true

require 'test_helper'

class FullNameHelperTest < ActionView::TestCase
  test 'full_name can return a full name for academic term' do
    assert_equal full_name(academic_terms(:fall_2017_2018)), '2017 - 2018 / Güz'
  end

  test 'full_name can return a full name for identity' do
    assert_equal full_name(identities(:formal_user)), 'john doe'
  end

  test 'full_name can return a full name for employee' do
    assert_equal full_name(employees(:serhat_active)), 'Araştırma Görevlisi john doe'
  end
end
