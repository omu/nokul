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
  validates_uniqueness_of :name
  validates_uniqueness_of :alpha_2_code

  # validations: length
  validates_length_of :name
  validates_length_of :alpha_2_code

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
end
