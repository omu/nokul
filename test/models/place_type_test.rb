# frozen_string_literal: true

require 'test_helper'

class PlaceTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper

  # relations
  has_one :building, dependent: :destroy
  has_one :classroom, dependent: :destroy

  # custom methods
  test 'number_of_children method' do
    assert_equal place_types(:egitim).children.count, place_types(:egitim).number_of_children
  end

  test 'non_roots method' do
    assert_not_includes PlaceType.non_roots, place_types(:egitim)
  end
end
