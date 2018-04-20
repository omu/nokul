# frozen_string_literal: true

module UnitStatus
  extend ActiveSupport::Concern

  included do
    enum status: { passive: 0, active: 1, partially_passive: 3, closed: 4, archived: 5, unknown: 6 }
  end
end
