module InstructionType
  extend ActiveSupport::Concern

  included do
    enum instruction_type: { formal: 1, evening: 2, distance: 3, open: 4 }
  end
end
