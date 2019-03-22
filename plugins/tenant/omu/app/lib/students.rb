# frozen_string_literal: true

module Students
  module_function

  NUMBER_LENGTH = 8

  def start_of_active_academic_year
    Date.current.strftime '%y' # TODO: placeholder
  end

  def number_generator(unit)
    # TODO: dispatch short or long number generator by looking into to the unit
  end

  def short_number_generator(unit_code, starting_sequence)
    prefix, length = [unit_code, start_of_active_academic_year], 3 # rubocop:disable ParallelAssignment
    raise 'Bad number length' unless [*prefix, starting_sequence].join.length == NUMBER_LENGTH

    Support::Codification.sequential_numeric_codes starting_sequence, prefix: prefix, length: length, base: 10
  end

  def long_number_generator(unit_code, starting_sequence)
    prefix, length = [unit_code], 5 # rubocop:disable ParallelAssignment
    raise 'Bad number length' unless [*prefix, starting_sequence].join.length == NUMBER_LENGTH

    Support::Codification.sequential_numeric_codes starting_sequence, prefix: prefix, length: length, base: 10
  end
end
