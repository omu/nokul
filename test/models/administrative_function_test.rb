# frozen_string_literal: true

require 'test_helper'

class AdministrativeFunctionTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :duties
  has_many :positions

  # validations: presence
  validates_presence_of :code
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # callbacks
  test 'callbacks must titlecase the full_address of an address' do
    administrative_functions(:rector).update!(name: 'REKTÖR')
    assert_equal administrative_functions(:rector).name, 'Rektör'
  end
end
