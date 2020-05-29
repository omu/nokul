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
    @regulation = regulations(:undergraduate)
  end

  test 'clauses should be accessible' do
    assert @regulation.clauses.present?
  end

  test 'klass method' do
    assert_equal @regulation.klass, V1::UndergraduateRegulation
  end

  test 'name method' do
    assert_equal @regulation.name, I18n.t("regulations.v1.#{@regulation.identifier}")
  end
end
