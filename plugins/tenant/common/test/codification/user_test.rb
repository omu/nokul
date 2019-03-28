# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Tenant
    module Codification
      class UserTest < ActiveSupport::TestCase
        test 'name_generate works by default' do
          user_name = User.name_generate(first_name: 'Mustafa Kemal',
                                         last_name:  'Atatürk',
                                         memory:     Support::Codification::SimpleMemory.new)

          sep = Regexp.escape(Codification::User.const.random_suffix_separator)
          len = Codification::User.const.random_suffix_length
          assert_match(/^mkataturk#{sep}\d{#{len}}$/, user_name)
        end

        test 'name_generate works with options' do
          user_name = User.name_generate(first_name: 'Mustafa Kemal',
                                         last_name:  'Atatürk',
                                         memory:     Support::Codification::SimpleMemory.new,
                                         interfix:   '-')

          sep = Regexp.escape(Codification::User.const.random_suffix_separator)
          len = Codification::User.const.random_suffix_length
          assert_match(/^m-k-ataturk#{sep}\d{#{len}}$/, user_name)
        end

        test 'name_suggest works by default' do
          actual = User.name_suggest(first_name: 'Mustafa Kemal',
                                     last_name:  'Atatürk',
                                     memory:     Support::Codification::SimpleMemory.new)

          expected = %w[
            mustafa.ataturk
            kemal.ataturk
            mustafa.kemal.ataturk
          ]

          assert_equal expected, actual
        end

        test 'name_suggest works with options' do
          actual = User.name_suggest(first_name:  'Mustafa Kemal',
                                     last_name:   'Atatürk',
                                     memory:      Support::Codification::SimpleMemory.new,
                                     alternative: :abbreviated,
                                     interfix:    nil)

          expected = %w[
            mkataturk
            mkemala
            mustafaka
            mkemalataturk
            mustafakataturk
            mustafakemala
            mustafakemalataturk
          ]

          assert_equal expected, actual
        end
      end
    end
  end
end
