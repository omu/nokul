# frozen_string_literal: true

require 'ostruct'

class Hash
  # Stolen and refactored from https://stackoverflow.com/a/11137694
  def to_deep_ostruct
    internal_hashes = {}
    each do |key, value|
      internal_hashes[key] = value if value.is_a?(Hash)
    end

    return OpenStruct.new self if internal_hashes.empty?

    duplicate = dup
    internal_hashes.each do |key, value|
      duplicate[key] = value.to_deep_ostruct
    end
    OpenStruct.new(duplicate)
  end
end
