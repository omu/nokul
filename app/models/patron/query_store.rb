# frozen_string_literal: true

module Patron
  class QueryStore < ApplicationRecord
    include Patron::Scope::Store::Accessor
    include Patron::Scope::Store::Validation

    # search
    include PgSearch
    pg_search_scope(
      :search,
      against: %i[name scope],
      using: { tsearch: { prefix: true } }
    )

    # relations
    has_many :scope_assignmets, dependent: :destroy
    has_many :users, through: :scope_assignmets

    # stores
    store :parameters, coder: JSON

    # validations
    validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :scope_name, length: { maximum: 255 }, inclusion: { in: Patron.scope_names }
    validates :parameters, presence: true

    def scope_klass
      scope_name.to_s.safe_constantize
    end
  end
end
