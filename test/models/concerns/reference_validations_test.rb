# frozen_string_literal: true

require 'test_helper'

module ReferenceValidationsTest
  extend ActiveSupport::Concern

  included do
    # validation tests for the presence of listed properties
    %i[
      name
      code
    ].each do |property|
      test "presence validations for #{property} of a reference" do
        @object.send("#{property}=", nil)
        refute @object.valid?
        assert_not_nil @object.errors[property]
      end
    end

    # validation tests for the uniqueness of listed properties
    %i[
      name
      code
    ].each do |property|
      test "uniqueness validations for #{property} of a reference" do
        fake_object = @object.dup
        assert_not_nil fake_object.errors[property]
      end
    end
  end
end
