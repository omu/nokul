# frozen_string_literal: true

require 'nokul-support'

module Students
  Numerator = Support::Coding::PrefixedNumerator # Length is 8 by default

  module_function

  def start_of_active_academic_year
    Date.current.strftime '%y' # TODO: placeholder
  end

  # Example:
  #
  #   numerator = numerator('203', nil)
  #
  #   numerator.number #=> 20319001
  #   numerator.number #=> 20319002
  #
  #   numerator.next_sequence  #=> 003 (without actually incrementing number)
  #   numerator.first_sequence #=> 001
  #
  #   numerator = numerator('203', '078')
  #
  #   numerator.number #=> 20319078
  #   numerator.number #=> 20319079
  #
  def numerator(unit_code, starting_seqeuence)
    Numerator.new starting_seqeuence, leading_prefix: unit_code, trailing_prefix: start_of_active_academic_year
  end

  # Example:
  #
  #   long_numerator = long_numerator('203', nil)
  #
  #   long_numerator.number #=> 20300001
  #   long_numerator.number #=> 20300002
  #
  #   long_numerator.next_sequence  #=> 00003 (without actually incrementing number)
  #   long_numerator.first_sequence #=> 00001
  #
  #   long_numerator = long_numerator('203', '078')
  #
  #   long_numerator.number #=> 20300078
  #   long_numerator.number #=> 20300079
  #
  def long_numerator(unit_code, starting_seqeuence)
    Numerator.new starting_seqeuence, leading_prefix: unit_code, trailing_prefix: nil
  end
end
