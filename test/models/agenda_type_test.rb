# frozen_string_literal: true

require 'test_helper'

class AgendaTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :agendas, dependent: :nullify

  # validations: presence
  validates_presence_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  before_save :capitalize_attributes
end
