# frozen_string_literal: true

require 'test_helper'

class I18nHelperTest < ActionView::TestCase
  test 'enum_options_for_select method' do
    assert_equal([
                   %w[Pasif passive], %w[Aktif active]
                 ], enum_options_for_select(Course, :status))
  end

  test 'collection_options_for_select method' do
    assert_equal([
                   %w[Dönemlik periodic], %w[Yıllık yearly]
                 ], collection_options_for_select(%i[periodic yearly]))
  end
end
