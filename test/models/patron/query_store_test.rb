# frozen_string_literal: true

require 'test_helper'

class DummyModel < ApplicationRecord
  attr_reader :name, :desc

  def self.attribute_names
    %w[name desc]
  end
end

class DummyModelScope < Patron::Scope::Base
  filter :name
  filter :desc
end

module Patron
  class QueryStoreTest < ActiveSupport::TestCase
    extend Support::Minitest::AssociationHelper
    extend Support::Minitest::EnumerationHelper
    extend Support::Minitest::ValidationHelper

    # enumerations
    enum type: { exclusive: 0, inclusive: 1 }

    # relations
    has_many :scope_assignments, class_name: 'Patron::ScopeAssignment', dependent: :destroy
    has_many :users, through: :scope_assignments

    # validations: presence
    validates_presence_of :name
    validates_presence_of :scope_name

    # validations: uniqueness
    validates_uniqueness_of :name

    # validations: length
    validates_length_of :name
    validates_length_of :scope_name

    setup do
      @query_store = patron_query_stores(:unit_scope_muhendislik)
    end

    test 'scope_klass method' do
      assert_equal @query_store.scope_klass, DummyModelScope
    end

    test 'full_name method' do
      assert_equal @query_store.full_name, "#{@query_store.name} - #{@query_store.scope_name}"
    end

    test 'active? method' do
      assert @query_store.active?
    end

    test 'passive? method' do
      query_store = patron_query_stores(:passive)
      assert query_store.passive?
    end

    test 'static? method' do
      assert @query_store.static?(:name)
    end

    test 'dynamic? method' do
      assert @query_store.dynamic?(:desc)
    end
  end
end
