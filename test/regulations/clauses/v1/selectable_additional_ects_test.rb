# frozen_string_literal: true

require 'test_helper'

module Clauses
  module V1
  class SelectableAdditionalEctsTest < ActiveSupport::TestCase
    setup do
      @klass = Lisans::SelectableAdditionalEcts
    end

    test 'call' do
      assert_equal  @klass.call(students(:serhat)), 6
      assert_equal  @klass.call(students(:john)), 15
      assert_equal  @klass.call(students(:mike)), 0
    end

    test 'properties' do
      {
        name:         'Selectable Additional ECTS',
        identifier:   :lisans_selectable_additional_ects,
        number:       10,
        sub_articles: [7, 8, 9, 10, 11],
        version:      31_103
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
