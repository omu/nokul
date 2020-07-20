# frozen_string_literal: true

require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper

  # relations
  belongs_to :place_type
  belongs_to :unit
  has_many :classrooms, dependent: :destroy

  # scopes
  test 'actives scope returns active buildings' do
    assert_includes(Building.actives, buildings(:muhendislik_fakultesi_a_blok))
    assert_not_includes(Building.actives, buildings(:egitim_fakultesi_d_blok))
  end

  test 'passives scope returns passive buildings' do
    assert_includes(Building.passives, buildings(:egitim_fakultesi_d_blok))
    assert_not_includes(Building.passives, buildings(:muhendislik_fakultesi_a_blok))
  end
end
