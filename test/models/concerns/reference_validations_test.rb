# frozen_string_literal: true

require 'test_helper'

module ReferenceValidationsTest
  extend ActiveSupport::Concern

  included do
    # validations: presence
    %i[
      name
      code
    ].each do |property|
      test "presence validations for #{property} of a reference" do
        @object.send("#{property}=", nil)
        assert_not @object.valid?
        assert_not_nil @object.errors[property]
      end
    end

    # validations: uniqueness
    %i[
      name
      code
    ].each do |property|
      test "uniqueness validations for #{property} of a reference" do
        fake_object = @object.dup
        assert_not_nil fake_object.errors[property]
      end
    end

    # other validations
    test 'name can not be longer than 255 characters' do
      fake = @object.dup
      fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
      assert_not fake.valid?
      assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
    end

    test 'code must be an integer greater than or equal to 0' do
      def error_codes(fake)
        fake.errors.details[:code].map { |err| err[:error] }
      end

      fake = @object.dup
      fake.code = -1
      assert_not fake.valid?
      assert error_codes(fake).include?(:greater_than_or_equal_to)

      fake.code = 'hello there!'
      assert_not fake.valid?
      assert error_codes(fake).include?(:not_a_number)
    end
  end
end
