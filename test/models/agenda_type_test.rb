# frozen_string_literal: true

require 'test_helper'

class AgendaTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  has_many :agendas

  # validations: presence
  validates_presence_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  has_save_callback :capitalize_attributes, :before
end
