# frozen_string_literal: true

require_relative 'refinery'

module Coding
  class Code
    include Comparable

    using Refinery

    attr_reader :base, :length

    def initialize(value_string, base = nil)
      @length = value_string.length
      @base   = base || determine_base_from_value_string(value_string)
      @value  = value_string.to_number(@base)
    end

    def succ
      self.class.new(value.succ.to_string(base, length), base)
    end

    def <=>(other)
      value <=> other.send(:value)
    end

    def inspect
      value.to_string(base, length)
    end

    def to_s
      inspect
    end

    def ends
      value_string =
        case base
        when 10 then '9' * length
        when 16 then 'F' * length
        when 36 then 'Z' * length
        end
      self.class.new value_string, base
    end

    protected

    attr_reader :value

    def determine_base_from_value_string(value_string)
      case value_string
      when /[g-zG-Z]/ then 36
      when /[a-fA-F]/ then 16
      else                 10
      end
    end
  end
end
