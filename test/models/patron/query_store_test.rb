# frozen_string_literal: true

require 'test_helper'

module Patron
  class QueryStoreTest < ActiveSupport::TestCase
    extend Support::Minitest::AssociationHelper
    extend Support::Minitest::ValidationHelper

    # relations
    has_many :scope_assignments, dependent: :destroy
    has_many :users, through: :scope_assignments

    # validations: presence
    validates_presence_of :name
    validates_presence_of :scope_name

    # validations: uniqueness
    validates_uniqueness_of :name

    # validations: length
    validates_length_of :name
    validates_length_of :scope_name

    test 'scope_klass method' do
      query_store = patron_query_stores(:unit_scope_muhendislik)
      assert_equal query_store.scope_klass, UnitScope
    end
  end
end
