# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class MemoryTest < ActiveSupport::TestCase
        module TestRefusingMemory
          class RefusingMemory < Memory
            def remember(*); end

            def remember?(*)
              true
            end
          end
        end

        test 'sub classing should work as expected' do
          memory = TestRefusingMemory::RefusingMemory.new
          assert memory.remember? 19
        end

        test 'simple memory should work as expected' do
          memory = SimpleMemory.new

          refute memory.remember? 19

          assert_equal 23, memory.remember(23)
          assert memory.remember? 23

          assert_nil memory.learn(23)

          assert_equal 17, memory.learn(17)
          assert memory.remember? 17
        end
      end
    end
  end
end
