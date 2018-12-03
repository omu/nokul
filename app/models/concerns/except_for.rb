# frozen_string_literal: true

module ExceptFor
  extend ActiveSupport::Concern

  class_methods do
    def except_for(*ids)
      scope = current_scope || self
      scope.where.not(id: ids)
    end
  end
end
