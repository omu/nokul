# frozen_string_literal: true

require 'test_helper'

class AdministrativeFunctionTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :positions
  has_many :duties

  # validations: presence
  validates_presence_of :name
  validates_presence_of :code

  # validations: uniqueness
  test 'name and code of administrative_functions must be unique' do
    fake = administrative_functions(:rector).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
    assert_not_empty fake.errors[:code]
  end

  # callbacks
  test 'callbacks must titlecase the full_address of an address' do
    administrative_functions(:rector).update!(name: 'REKTÖR')
    assert_equal administrative_functions(:rector).name, 'Rektör'
  end
end
