# frozen_string_literal: true

require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :employees, dependent: :nullify

  # validations: presence
  validates_presence_of :branch
  validates_presence_of :code
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :branch
  validates_length_of :code
  validates_length_of :name
end
