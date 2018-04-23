# frozen_string_literal: true

module UnitStatus
  extend ActiveSupport::Concern

  included do
    enum status: { passive: 0, active: 1, partially_passive: 2, closed: 3, archived: 4, unknown: 5 }
  end
end
