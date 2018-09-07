# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  setup do
    @language = languages(:turkce)
  end

  # validations: presence
  %i[
    name
    iso
  ].each do |property|
    test "presence validations for #{property} of a language" do
      @language.send("#{property}=", nil)
      assert_not @language.valid?
      assert_not_empty @language.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    iso
    yoksis_code
  ].each do |property|
    test "uniqueness validations for #{property} of a language" do
      fake = @language.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end
end
