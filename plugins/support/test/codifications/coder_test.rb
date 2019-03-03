# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CodificationsCoderTest < ActiveSupport::TestCase
      test 'basic use case should just work' do
        coder = Codifications::Coder.new '000'
        assert_equal '000', coder.run
        assert_equal '001', coder.run
      end

      test 'can specify the end of range' do
        coder = Codifications::Coder.new '000', ends: '003'

        assert_equal '000', coder.run
        assert_equal '001', coder.run
        assert_equal '002', coder.run
        assert_equal '003', coder.run

        assert_raises(Codifications::Coder::Consumed) { coder.run }
      end

      test 'can run pools' do
        coder = Codifications::Coder.new '000', ends: '002'
        assert(pool = coder.pool).is_a? Array
        assert_equal 3, pool.size
        assert_equal '000-001-002', pool.join('-')
      end

      test 'can deny certain symbols based on a regex pattern' do
        # simple case
        coder = Codifications::Coder.new '000', deny: /[0]$/
        assert_equal '001', coder.run
        assert_equal '002', coder.run

        # complex case
        coder = Codifications::Coder.new '000', ends: '999', deny: /(?<digit>)\g<digit>\g<digit>/
        %w[000 111 222 333 444 555 666 777 888 999].each do |denied|
          assert_equal false, coder.pool.include?(denied)
        end
      end

      test 'can work with a simple memory' do
        memory = Codifications::SimpleMemory.new '002' => true
        coder = Codifications::Coder.new '000', memory: memory

        assert_equal '000', coder.run
        assert_equal '001', coder.run
        assert_equal '003', coder.run
      end
    end
  end
end
