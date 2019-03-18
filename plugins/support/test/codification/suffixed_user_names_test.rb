# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class SuffixedUserNamesTest < ActiveSupport::TestCase
        test 'simple use case works' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez]

          2.times do
            name = coder.run
            assert_match(/ggmarquez[.]\d+/, name)
            assert name.start_with? 'ggmarquez.'
          end
        end

        test 'can consume a common random coder' do
          # Common random coder with 10 unique random number
          random = Codification.random_numeric_codes(0..9)

          # Consume half of the randoms
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], random: random
          5.times do
            name = coder.run
            assert_match(/ggmarquez[.]\d+/, name)
            assert name.start_with? 'ggmarquez.'
          end

          # Consume other half of the randoms by another coder
          other = Codification.suffixed_user_names %w[gabriel garcia marquez], random: random
          5.times do
            name = coder.run
            assert_match(/ggmarquez[.]\d+/, name)
            assert name.start_with? 'ggmarquez.'
          end

          # Now both of the coders should be consumed
          assert_raise(Consumed) { coder.run }
          assert_raise(Consumed) { other.run }
        end

        test 'simple use case with memory works' do
          memory = SimpleMemory.new

          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], memory: memory

          2.times do
            name = coder.run
            assert_match(/ggmarquez[.]\d+/, name)
            assert name.start_with? 'ggmarquez.'
          end
        end

        test 'prefix option works' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], prefix: 'user.'

          2.times do
            name = coder.run
            assert_match(/user[.]ggmarquez[.]\d+/, name)
            assert name.start_with? 'user.ggmarquez.'
          end
        end

        test 'regex post process option works' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], post_process: /[^z][.]/

          2.times do
            name = coder.run
            assert_match(/ggarciam[.]\d+/, name)
            assert name.start_with? 'ggarciam.'
          end
        end

        test 'proc post process option works' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], post_process: proc { |name| name + '.a' }

          2.times do
            name = coder.run
            assert_match(/ggmarquez[.]\d+[.]a/, name)
            assert name.end_with? '.a'
          end
        end

        test 'offensive words should not be seen' do
          coder = Codification.suffixed_user_names %w[suat alak]

          2.times { assert coder.run.start_with? 'suata.' } # not "salak"
        end

        test 'reserved words should not be seen' do
          coder = Codification.suffixed_user_names %w[william hile]

          2.times { assert coder.run.start_with? 'williamh.' } # noit "while"
        end

        test 'can produce available names' do
          available = Codification.suffixed_user_names(%w[suat alak]).available(3)
          assert_equal 3, available.size
          assert available.all? do |name|
            name.start_with?('suata.')
          end
        end
      end
    end
  end
end
