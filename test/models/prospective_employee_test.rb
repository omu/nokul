# frozen_string_literal: true

require 'test_helper'

class ProspectiveEmployeeTest < ActiveSupport::TestCase
  include ProspectiveTest

  # relations
  belongs_to :title

  # validations: presence
  validates_presence_of :date_of_birth
  validates_presence_of :email
  validates_presence_of :staff_number

  # validations: length
  validates_length_of :staff_number
end
