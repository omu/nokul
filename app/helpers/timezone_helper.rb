# frozen_string_literal: true

module TimezoneHelper
  def timezone_list_with_offset
    arr = []
    ActiveSupport::TimeZone.all.each do |timezone|
      arr << [timezone.name + " (#{timezone.formatted_offset})", timezone.name]
    end
    arr
  end
end
