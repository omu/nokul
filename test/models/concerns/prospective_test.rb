# frozen_string_literal: true

require 'test_helper'

module ProspectiveTest
  extend ActiveSupport::Concern

  # callbacks
  included do
    extend Nokul::Support::Minitest::AssociationHelper
    extend Nokul::Support::Minitest::CallbackHelper
    extend Nokul::Support::Minitest::EnumerationHelper
    extend Nokul::Support::Minitest::ValidationHelper

    # relations
    belongs_to :unit

    # validations: presence
    validates_presence_of :first_name
    validates_presence_of :gender
    validates_presence_of :id_number
    validates_presence_of :last_name

    # validations: uniqueness
    validates_uniqueness_of :id_number

    # validations: length
    validates_length_of :email
    validates_length_of :first_name
    validates_length_of :last_name
    validates_length_of :mobile_phone

    # enums
    enum gender: { male: 1, female: 2 }

    # callbacks
    before_validation :normalize_attributes
  end
end
