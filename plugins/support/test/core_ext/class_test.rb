# frozen_string_literal: true

require 'test_helper'

class ClassTest < ActiveSupport::TestCase
  module TestClassesOne
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
    assert_equal %w[foo bar child_addition], TestClassesOne::NonConveyedBase.array_attr
    assert_equal %w[foo bar],                TestClassesOne::ConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestClassesOne::ChildFromNonConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestClassesOne::ChildFromConveyedBase.array_attr

    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestClassesOne::NonConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar'],                      TestClassesOne::ConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestClassesOne::ChildFromNonConveyedBase.hash_attr
    assert_equal Hash[x: 'foo', y: 'bar', z: 'child_addition'], TestClassesOne::ChildFromConveyedBase.hash_attr
  end

  module TestClassesTwo
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
    assert_equal %w[foo bar],                TestClassesTwo::ConveyedBase.array_attr
    assert_equal %w[foo bar child_addition], TestClassesTwo::ChildFromConveyedBase.array_attr

    refute TestClassesTwo::ConveyedBase.respond_to? :other
    assert_equal 'ok', TestClassesTwo::ChildFromConveyedBase.other
  end
end
