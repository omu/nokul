# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class AlternativeUserNamesTest < ActiveSupport::TestCase
        test 'simple use case works' do
          coder = Codification.alternative_user_names %w[gabriel garcia marquez]

          assert_equal'ggmarquez', coder.run
          assert_equal'ggarciam', coder.run
          assert_equal'gabrielgm', coder.run
          assert_equal'ggarciamarquez', coder.run
          assert_equal'gabrielgmarquez', coder.run
          assert_equal'gabrielgarciam', coder.run

          assert_raise(Consumed) { coder.run }
        end

        test 'simple use case with memory works' do
          memory = SimpleMemory.new

          coder = Codification.alternative_user_names %w[gabriel garcia marquez], memory: memory

          memory.remember 'ggarciam'

          assert_equal'ggmarquez', coder.run
          assert_equal'gabrielgm', coder.run
        end

        test 'prefix option works' do
          coder = Codification.alternative_user_names %w[gabriel garcia marquez], prefix: 'user.'

          assert_equal'user.ggmarquez', coder.run
          assert_equal'user.ggarciam', coder.run
        end

        test 'regex post process option works' do
          coder = Codification.alternative_user_names %w[gabriel garcia marquez], post_process: /.+garcia.+/

          assert_equal'ggarciam', coder.run
          assert_equal'ggarciamarquez', coder.run
          assert_equal'gabrielgarciam', coder.run

          assert_raise(Consumed) { coder.run }
        end

        test 'proc post process option works' do
          coder = Codification.alternative_user_names %w[gabriel garcia marquez], post_process: proc { |s| s.upcase }

          assert_equal'GGMARQUEZ', coder.run
          assert_equal'GGARCIAM', coder.run
        end

        test 'offensive words should not be seen' do
          coder = Codification.alternative_user_names %w[yilmaz ali rak]

          assert_equal 'yalir', coder.run
          assert_equal 'yilmazar', coder.run
          assert_equal 'yalirak', coder.run
          assert_equal 'yilmazarak', coder.run
          assert_equal 'yilmazalir', coder.run

          assert_raise(Consumed) { coder.run }
        end

        test 'reserved words should not be seen' do
          coder = Codification.alternative_user_names %w[william hile]

          assert_equal 'williamh', coder.run

          assert_raise(Consumed) { coder.run }
        end

        test 'can produce available names' do
          available = Codification.alternative_user_names(%w[suat alak]).available(3)
          assert_equal %w[suata], available
        end
      end
    end
  end
end
