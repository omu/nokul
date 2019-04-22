# frozen_string_literal: true

require 'test_helper'

module Patron
  class QueryStoreTest < ActiveSupport::TestCase
    extend Support::Minitest::AssociationHelper
    extend Support::Minitest::ValidationHelper

    # relations
    has_many :scope_assignmets, dependent: :destroy
    has_many :users, through: :scope_assignmets

    # validations: presence
    validates_presence_of :name
    validates_presence_of :scope_name

    # validations: uniqueness
    validates_uniqueness_of :name

    # validations: length
    validates_length_of :name
    validates_length_of :scope_name
  end
end
