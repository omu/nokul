module UnitStatus
  extend ActiveSupport::Concern
  included do
    enum status: %i(active partially_passive passive closed archived)
  end
end