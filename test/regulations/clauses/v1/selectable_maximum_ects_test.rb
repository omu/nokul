# frozen_string_literal: true

require 'test_helper'

module Clauses
  module V1
    class SelectableMaximumEctsTest < ActiveSupport::TestCase
      STORES = {
        default: {
          'yearly'   => 60,
          'periodic' => 30
        }
      }.freeze

      setup do
        @klass = Clauses::V1::SelectableMaximumEcts
      end

      test 'call method for V1::UndergraduateRegulation' do
        assert_equal  @klass.call(students(:serhat), executer: ::V1::UndergraduateRegulation), 36
        assert_equal  @klass.call(students(:john), executer: ::V1::UndergraduateRegulation), 45
        assert_equal  @klass.call(students(:mike), executer: ::V1::UndergraduateRegulation), 30
      end

      test 'identifier property should be accessible' do
        assert_equal @klass.identifier, :selectable_maximum_ects
      end

      test 'display_name property should be accessible' do
        assert_equal @klass.display_name, I18n.t("regulations.clauses/v1.#{@klass.identifier}")
      end

      STORES.each do |store_key, data|
        test "#{store_key} store" do
          assert_equal @klass.store(store_key), data
        end
      end

      test 'store method should be called without parameters' do
        assert_equal @klass.store, STORES[:default]
      end

      {
        ::V1::UndergraduateRegulation => {
          version: 31_103,
          number:  10,
          store:   :default
        }
      }.each do |regulation, metadata|
        test "should be registered to #{regulation}" do
          assert regulation.registered?(@klass.identifier)
        end

        test "metadata should be match for #{regulation}" do
          clause = regulation[@klass.identifier]
          assert_equal clause.version, metadata[:version]
          assert_equal clause.number, metadata[:number]
          assert_equal clause.paragraph, [*metadata[:paragraph]]
          assert_equal clause.subparagraph, [*metadata[:subparagraph]]
          assert_equal clause.store, metadata[:store]
        end
      end
    end
  end
end
