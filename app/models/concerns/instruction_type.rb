# frozen_string_literal: true

module InstructionType
  extend ActiveSupport::Concern

  included do
    enum instruction_type: { formal: 1, evening: 2, distance_education: 3, open_education: 4 }
  end
end
