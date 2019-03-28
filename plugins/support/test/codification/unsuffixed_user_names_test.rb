# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class UnsuffixedUserNamesTest < ActiveSupport::TestCase
        test 'simple use case with default works' do
          coder = Codification.unsuffixed_user_names %w[gabriel garcia marquez]

          assert_equal 'gabriel.marquez', coder.run
          assert_equal 'garcia.marquez', coder.run
          assert_equal 'gabriel.garcia.marquez', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'simple use case with non abbreviated options works' do
          options = { alternative: :non_abbreviated, interfix: '-' }
          coder = Codification.unsuffixed_user_names(%w[gabriel garcia marquez], **options)

          assert_equal 'gabriel-marquez', coder.run
          assert_equal 'garcia-marquez', coder.run
          assert_equal 'gabriel-garcia-marquez', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'simple use case with abbreviated options works' do
          options = { alternative: :abbreviated, interfix: nil }
          coder = Codification.unsuffixed_user_names(%w[gabriel garcia marquez], **options)

          assert_equal 'ggmarquez', coder.run
          assert_equal 'ggarciam', coder.run
          assert_equal 'gabrielgm', coder.run
          assert_equal 'ggarciamarquez', coder.run
          assert_equal 'gabrielgmarquez', coder.run
          assert_equal 'gabrielgarciam', coder.run
          assert_equal 'gabrielgarciamarquez', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'API with singular name works' do
          assert_equal 'gabriel.marquez', Codification.unsuffixed_user_name(%w[gabriel garcia marquez])
        end

        test 'simple use case with memory works' do
          memory = SimpleMemory.new

          coder = Codification.unsuffixed_user_names %w[gabriel garcia marquez], memory: memory

          memory.remember 'garcia.marquez'

          assert_equal 'gabriel.marquez', coder.run
          assert_equal 'gabriel.garcia.marquez', coder.run
        end

        test 'prefix option works' do
          coder = Codification.unsuffixed_user_names %w[gabriel garcia marquez], prefix: 'user.'

          assert_equal 'user.gabriel.marquez', coder.run
          assert_equal 'user.garcia.marquez', coder.run
          assert_equal 'user.gabriel.garcia.marquez', coder.run
        end

        test 'regex post process option works' do
          coder = Codification.unsuffixed_user_names %w[gabriel garcia marquez], post_process: /.*garcia/

          assert_equal 'garcia.marquez', coder.run
          assert_equal 'gabriel.garcia.marquez', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'proc post process option works' do
          coder = Codification.unsuffixed_user_names %w[gabriel garcia marquez], post_process: proc { |s| s.upcase }

          assert_equal 'GABRIEL.MARQUEZ', coder.run
          assert_equal 'GARCIA.MARQUEZ', coder.run
          assert_equal 'GABRIEL.GARCIA.MARQUEZ', coder.run
        end

        test 'offensive words should not be seen' do
          options = { alternative: :abbreviated, interfix: nil }
          coder = Codification.unsuffixed_user_names(%w[yilmaz ali rak], **options)

          assert_equal 'yalir', coder.run
          assert_equal 'yilmazar', coder.run
          assert_equal 'yalirak', coder.run
          assert_equal 'yilmazarak', coder.run
          assert_equal 'yilmazalir', coder.run
          assert_equal 'yilmazalirak', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'reserved words should not be seen' do
          options = { alternative: :abbreviated, interfix: nil }
          coder = Codification.unsuffixed_user_names(%w[william hile], **options)

          assert_equal 'williamh', coder.run
          assert_equal 'williamhile', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'can produce (non abbreviated) available names' do
          available = Codification.unsuffixed_user_names(%w[suat alak]).available(3)
          assert_equal %w[suat.alak], available
        end

        test 'can produce abbreviated available names' do
          options = { alternative: :abbreviated, interfix: nil }
          available = Codification.unsuffixed_user_names(%w[suat alak], **options).available(3)
          assert_equal %w[suata suatalak], available
        end
      end
    end
  end
end
