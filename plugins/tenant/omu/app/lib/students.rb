# frozen_string_literal: true

module Students
  module_function

  def start_of_active_academic_year
    Date.current.strftime '%y' # TODO: placeholder
  end

  def number_generator(unit)
    # TODO: dispatch short or long number generator by looking into to the unit
  end

  def short_number_generator(unit_code, starting_sequence)
    Support::Codification.sequential_numeric_codes starting_sequence, prefix: [unit_code, start_of_active_academic_year]
  end

  def long_number_generator(unit_code, starting_sequence)
    NumberGenerator.new starting_sequence, prefix: unit_code
    Support::Codification.sequential_numeric_codes starting_sequence, prefix: unit_code
  end
end
