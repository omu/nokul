# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :country
  has_many :addresses
  has_many :districts
  has_many :units

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code

  # validations: uniqueness
  %i[
    name
    alpha_2_code
  ].each do |property|
    test "uniqueness validations for #{property} of a city" do
      fake = cities(:samsun).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the alpha_2_code of a city' do
    city = City.create(
      name: 'wonderland',
      alpha_2_code: 'wl-11',
      country: countries(:turkey)
    )
    assert_equal city.name, 'Wonderland'
    assert_equal city.alpha_2_code, 'WL-11'
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  %i[
    name
    alpha_2_code
  ].each do |property|
    test "#{property} can not be longer than 255 characters" do
      fake = cities(:samsun).dup
      fake.send("#{property}=", long_string)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end
end
