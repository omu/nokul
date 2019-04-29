# frozen_string_literal: true

module Patron
  module Scopable
    extend ActiveSupport::Concern

    included do
      has_many :scope_assignments, class_name: 'Patron::ScopeAssignment', dependent: :destroy
      has_many :query_stores, -> { active }, class_name: 'Patron::QueryStore', through: :scope_assignments
    end
  end
end
