# frozen_string_literal: true

module Ruling
  module_function

  def rules(prefix_or_pattern)
    filter = case prefix_or_pattern
             when String then proc { |name| name.starts_with? prefix_or_pattern }
             when Regex  then proc { |name| name =~ prefix_or_pattern           }
             end
    Rule.registery.select { |klass| filter.call(klass.name.tableize) }
  end
end
