module UnitStatus
  extend ActiveSupport::Concern

  included do
    enum status: %i[passive active partially_passive closed archived unknown]
  end
end
