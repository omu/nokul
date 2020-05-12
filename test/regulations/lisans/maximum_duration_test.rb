# frozen_string_literal: true

require 'test_helper'

module Lisans
  class MaximumDurationTest < ActiveSupport::TestCase
    setup do
      @klass            = Lisans::MaximumDuration
      @unit             = units(:omu)
      @undergraduate    = units(:bilgisayar_muhendisligi_programi)
      @associate_degree = units(:buro_yonetimi_ve_yonetici_asistanligi_io)
    end

    test 'call' do
      assert_equal @klass.call(@undergraduate), 7
      assert_equal @klass.call(@associate_degree), 4
      assert_raise ArgumentError do
        @klass.call(@unit)
      end
    end

    test 'properties' do
      {
        name:         'Maximum Duration',
        identifier:   :lisans_maximum_duration,
        number:       8,
        sub_articles: [1],
        version:      31_103,
      }.each do |property, value|
        assert_equal @klass.public_send(property), value
      end
    end

    test 'register' do
      assert V1::UndergraduateRegulation.articles.key?(@klass.identifier)
    end
  end
end
