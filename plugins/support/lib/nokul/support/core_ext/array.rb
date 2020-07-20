# frozen_string_literal: true

class Array
  def clip(number_of_last_elements = 1)
    take size - number_of_last_elements
  end

  def join_affixed(**options)
    must_be_any_of! [String]

    "#{Array(options[:prefix]).join}#{join options[:interfix]}#{Array(options[:suffix]).join}"
  end
end
