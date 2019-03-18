# frozen_string_literal: true

class Array
  def clip(number_of_last_elements = 1)
    take size - number_of_last_elements
  end

  def affixed(**options)
    raise ArgumentError, 'must be a string array' unless all? { |string| string.is_a? String }

    "#{[*options[:prefix]].join}#{join options[:interfix]}#{[*options[:suffix]].join}"
  end
end
