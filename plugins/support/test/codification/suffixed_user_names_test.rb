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

        test 'API with singular name works' do
          name = Codification.suffixed_user_name %w[gabriel garcia marquez]

          assert_match(/ggmarquez[.]\d+/, name)
          assert name.start_with? 'ggmarquez.'
        end

        test 'can specify random suffix length' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], random_suffix_length: 1

          name = coder.run
          assert_match(/ggmarquez[.]\d{1}$/, name)
          assert name.start_with? 'ggmarquez.'

          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], random_suffix_length: 5

          name = coder.run
          assert_match(/ggmarquez[.]\d{5}$/, name)
          assert name.start_with? 'ggmarquez.'
        end

        test 'can specify random suffix separator' do
          coder = Codification.suffixed_user_names %w[gabriel garcia marquez], random_suffix_separator: '-'

          name = coder.run
          assert_match(/ggmarquez[-]\d+$/, name)
          assert name.start_with? 'ggmarquez-'
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
          available = Codification.suffixed_user_names(%w[suat alak]).available!(3)
          assert_equal 3, available.size
          assert available.all? do |name|
            name.start_with?('suata.')
          end
        end
      end
    end
  end
end
