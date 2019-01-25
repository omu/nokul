# frozen_string_literal: true

module Students
  Numerator = Support::Coding::PrefixedNumerator # Length is 8 by default

  module_function

  def start_of_active_academic_year
    Date.current.strftime '%y' # TODO: placeholder
  end

  def numerator(unit_code, starting_seqeuence)
    Numerator.new starting_seqeuence, leading_prefix: unit_code, trailing_prefix: start_of_active_academic_year
  end

  def long_numerator(unit_code, starting_seqeuence)
    Numerator.new starting_seqeuence, leading_prefix: unit_code
  end
end
