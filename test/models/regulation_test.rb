# frozen_string_literal: true

require 'test_helper'

class RegulationTest < ActiveSupport::TestCase
  extend Support::Minitest::ValidationHelper

  # validations: presence
  validates_presence_of :class_name
  validates_presence_of :effective_date

  # validations: length
  validates_length_of :class_name

  setup do
    @regulation = registrations(:undergraduate)
  end

  test 'articles' do
    assert_equal @regulation.articles.present?
  end

  test 'klass' do
    assert_equal @regulation.klass, V1::UndergraduateRegulation
  end

  test 'display_name callable' do
    assert_not_raises NoMethodError do
      @regulation.display_name
    end
  end
end
