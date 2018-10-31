# frozen_string_literal: true

require 'test_helper'

class CodingMemoryTest < ActiveSupport::TestCase
  class RefusingMemory < Coding::Memory
    def remember(*); end

    def remember?(*)
      true
    end
  end

  test 'custom memory should work' do
    generator = Coding::Generator.new '000', ends: '002', memory: RefusingMemory.new
    assert_raises(Coding::Generator::Consumed) { generator.generate }
  end
end
