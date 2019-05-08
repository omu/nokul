# frozen_string_literal: true

module Patron
  class QueryStore < ApplicationRecord
    include Patron::Scope::Store::Accessor
    include Patron::Scope::Store::Validation
    include PgSearch

    self.inheritance_column = nil

    # callbacks
    after_update { self.parameters = nil }

    # enums
    enum type: { exclude: 0, include: 1 }

    # search
    pg_search_scope(
      :search,
      against: %i[name scope_name],
      using: { tsearch: { prefix: true } }
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

    def full_name
      "#{name} - #{scope_name}"
    end

    def scope_klass
      scope_name.to_s.safe_constantize
    end
  end
end
