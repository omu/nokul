# frozen_string_literal: true

require 'test_helper'

class CodingGeneratorTest < ActiveSupport::TestCase
  test 'basic use case should just work' do
    generator = Coding::Generator.new '000'
    assert_equal '000', generator.generate
    assert_equal '001', generator.generate
  end

  test 'can specify the end of range' do
    generator = Coding::Generator.new '000', ends: '003'

    assert_equal '000', generator.generate
    assert_equal '001', generator.generate
    assert_equal '002', generator.generate
    assert_equal '003', generator.generate

    assert_raises(Coding::Generator::Consumed) { generator.generate }
  end

  test 'can generate pools' do
    generator = Coding::Generator.new '000', ends: '002'
    assert(pool = generator.pool).is_a? Array
    assert_equal 3, pool.size
    assert_equal '000-001-002', pool.join('-')
  end

  test 'can deny certain symbols based on a regex pattern' do
    # simple case
    generator = Coding::Generator.new '000', deny: /[0]$/
    assert_equal '001', generator.generate
    assert_equal '002', generator.generate

    # complex case
    generator = Coding::Generator.new '000', ends: '999', deny: /(?<digit>)\g<digit>\g<digit>/
    %w[000 111 222 333 444 555 666 777 888 999].each do |denied|
      assert_equal false, generator.pool.include?(denied)
    end
  end

  test 'can work with a simple memory' do
    memory = Coding::SimpleMemory.new '002' => true
    generator = Coding::Generator.new '000', memory: memory

    assert_equal '000', generator.generate
    assert_equal '001', generator.generate
    assert_equal '003', generator.generate
  end
end
