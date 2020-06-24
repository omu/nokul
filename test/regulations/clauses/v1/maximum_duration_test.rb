# frozen_string_literal: true

require 'test_helper'

module Clauses
  module V1
    class MaximumDurationTest < ActiveSupport::TestCase
      STORES = {
        default: {
          2 => 4,
          4 => 7,
          5 => 8,
          6 => 9
        }
      }.freeze

      setup do
        @klass            = Clauses::V1::MaximumDuration
        @unit             = units(:omu)
        @undergraduate    = units(:bilgisayar_muhendisligi_programi)
        @associate_degree = units(:buro_yonetimi_ve_yonetici_asistanligi_io)
      end

      test 'call method for V1::UndergraduateRegulation' do
        assert_equal @klass.call(@undergraduate, executer: ::V1::UndergraduateRegulation), 7
        assert_equal @klass.call(@associate_degree, executer: ::V1::UndergraduateRegulation), 4
        assert_raise ArgumentError do
          @klass.call(@unit, executer: ::V1::UndergraduateRegulation)
        end
      end

      test 'identifier property should be accessible' do
        assert_equal @klass.identifier, :maximum_duration_of_education
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
          version:   31_103,
          number:    8,
          paragraph: 1,
          store:     :default
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
