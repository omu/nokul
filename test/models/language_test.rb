# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  setup do
    @language = languages(:turkce)
  end

  # relations
  %i[
    courses
    prospective_students
  ].each do |property|
    test "language can communicate with #{property}" do
      assert @language.send(property)
    end
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
  ].each do |property|
    test "uniqueness validations for #{property} of a language" do
      fake = @language.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # other validations
  test 'name and iso can not be longer than 255 characters' do
    fake = languages(:turkce).dup
    random_long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    fake.name = random_long_string
    fake.iso = random_long_string
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
    assert fake.errors.details[:iso].map { |err| err[:error] }.include?(:too_long)
  end

  # callbacks
  test 'callbacks must titlecase the name of a language' do
    language = Language.create(name: 'jewish', iso: 'jww')
    assert_equal language.name, 'Jewish'
    assert_equal language.iso, 'JWW'
  end
end
