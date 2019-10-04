# frozen_string_literal: true

module Patron
  class QueryStore < ApplicationRecord
    include Patron::Scope::Store::Accessor
    include Patron::Scope::Store::Validation
    include PgSearch::Model

    self.inheritance_column = nil

    # callbacks
    after_update { self.parameters = nil }

    # enums
    enum type: { exclusive: 0, inclusive: 1 }

    # search
    pg_search_scope(
      :search,
      against: %i[name scope_name],
      using:   { tsearch: { prefix: true } }
    )

    # relations
    has_many :scope_assignments, class_name: 'Patron::ScopeAssignment', dependent: :destroy
    has_many :users, through: :scope_assignments

    # scopes
    scope :active, -> { where(scope_name: Patron.scope_names) }

    # stores
    store :parameters, coder: JSON

    # validations
    validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :scope_name, length: { maximum: 255 }, inclusion: { in: ->(_) { Patron.scope_names } }
    validates :parameters, presence: true
    validates :type, inclusion: { in: types.keys }

    # helper methods
    def full_name
      "#{name} - #{scope_name}"
    end

    def scope_klass
      scope_name.to_s.safe_constantize
    end

    def active?
      Patron.scope_names.include?(scope_name)
    end

    def passive?
      !active?
    end

    def static?(attribute)
      value_for(attribute, :value_type) == 'static'
    end

    def dynamic?(attribute)
      value_for(attribute, :value_type) == 'dynamic'
    end
  end
end
