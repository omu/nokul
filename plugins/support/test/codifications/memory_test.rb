# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CodificationsMemoryTest < ActiveSupport::TestCase
      class RefusingMemory < Codifications::Memory
        def remember(*); end

        def remember?(*)
          true
        end
      end

      test 'custom memory should work' do
        generator = Codifications::Generator.new '000', ends: '002', memory: RefusingMemory.new
        assert_raises(Codifications::Generator::Consumed) { generator.generate }
      end
    end
  end
end
