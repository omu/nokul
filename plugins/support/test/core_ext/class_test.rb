# frozen_string_literal: true

require 'test_helper'

class ClassTest < ActiveSupport::TestCase
  module TestOne
    class NonConveyedBase
      class_attribute :array_attr, default: %w[foo bar]
      class_attribute :hash_attr, default: { x: 'foo', y: 'bar' }
    end

    class ConveyedBase
      class_attribute :array_attr, default: %w[foo bar]
      class_attribute :hash_attr, default: { x: 'foo', y: 'bar' }

      inherited_by_conveying_attributes :array_attr, :hash_attr
    end

    class ChildFromNonConveyedBase < NonConveyedBase
      array_attr << 'child_addition'
      hash_attr.merge! z: 'child_addition'
    end

    class ChildFromConveyedBase < ConveyedBase
      array_attr << 'child_addition'
      hash_attr.merge! z: 'child_addition'
    end
  end

  test 'inherited_by_conveying_attributes works' do
    assert_equal %w[foo bar child_addition], TestOne::NonConveyedBase.array_attr
    assert_equal %w[foo bar],                TestOne::ConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestOne::ChildFromNonConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestOne::ChildFromConveyedBase.array_attr

    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestOne::NonConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar'],                      TestOne::ConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestOne::ChildFromNonConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestOne::ChildFromConveyedBase.hash_attr
  end

  module TestTwo
    class ConveyedBase
      class_attribute :array_attr, default: %w[foo bar]

      inherited_by_conveying_attributes :array_attr do |child|
        child.class_attribute :other, default: 'ok'
      end
    end

    class ChildFromConveyedBase < ConveyedBase
      array_attr << 'child_addition'
    end
  end

  test 'inherited_by_conveying_attributes with block works' do
    assert_equal %w[foo bar],                TestTwo::ConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestTwo::ChildFromConveyedBase.array_attr

    refute TestTwo::ConveyedBase.respond_to? :other
    assert_equal 'ok', TestTwo::ChildFromConveyedBase.other
  end
end
