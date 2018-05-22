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
  end
end
