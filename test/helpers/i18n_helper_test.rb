# frozen_string_literal: true

require 'test_helper'

class I18nHelperTest < ActionView::TestCase
  test 'enum_options_for_select method' do
    assert_equal enum_options_for_select(Course, :status), [
      %w[Pasif passive], %w[Aktif active]
    ]
  end

  test 'collection_options_for_select method' do
    assert_equal collection_options_for_select(%i[periodic yearly]), [
      %w[Dönemlik periodic], %w[Yıllık yearly]
    ]
  end
end
