# frozen_string_literal: true

require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :employees

  # validations: presence
  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :branch

  # validations: uniqueness
  validates_uniqueness_of :name

  # other validations
  test 'name, code and branch can not be longer than 255 characters' do
    fake = titles(:professor).dup
    random_long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    fake.name = random_long_string
    fake.code = random_long_string
    fake.branch = random_long_string
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
    assert fake.errors.details[:code].map { |err| err[:error] }.include?(:too_long)
    assert fake.errors.details[:branch].map { |err| err[:error] }.include?(:too_long)
  end
end
