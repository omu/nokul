# frozen_string_literal: true

require 'test_helper'

module ReferenceValidationsTest
  extend ActiveSupport::Concern

  included do
    test 'presence validations for the name field of references' do
      @object.name = nil
      refute @object.valid?
      assert_not_nil @object.errors[:name]
    end

    test 'presence validations for the code field of references' do
      @object.code = nil
      refute @object.valid?
      assert_not_nil @object.errors[:code]
    end

    test 'uniqueness validations for the reference objects' do
      fake_object = @object.dup
      refute fake_object.valid?
    end

    test 'uniqueness validations for the name field of references' do
      fake_object = @object.dup
      assert_not_nil fake_object.errors[:name]
    end

    test 'uniqueness validations for the code field of references' do
      fake_object = @object.dup
      assert_not_nil fake_object.errors[:code]
    end
  end
end
