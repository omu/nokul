# frozen_string_literal: true

require 'test_helper'

class AdministrativeFunctionTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  has_many :positions
  has_many :duties

  # validations: presence
  %i[
    name
    code
  ].each do |property|
    test "presence validations for #{property} of an employee" do
      administrative_functions(:rector).send("#{property}=", nil)
      assert_not administrative_functions(:rector).valid?
      assert_not_empty administrative_functions(:rector).errors[property]
    end
  end

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
