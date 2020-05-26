# frozen_string_literal: true

require 'test_helper'

module Clauses
  module V1
  class SelectableMaximumEctsTest < ActiveSupport::TestCase
    setup do
      @klass = Lisans::SelectableMaximumEcts
    end

    test 'call' do
      assert_equal @klass.call(students(:serhat)), 36
      assert_equal @klass.call(students(:john)), 45
      assert_equal @klass.call(students(:mike)), 30
    end

    test 'properties' do
      {
        name:       'Selectable Maximum ECTS',
        identifier: :lisans_selectable_maximum_ects,
        number:     10,
        version:    31_103
      }.each do |property, value|
        assert_equal @klass.public_send(property), value
      end
    end

    test 'register' do
      assert V1::UndergraduateRegulation.articles.key?(@klass.identifier)
    end
  end
end
end
