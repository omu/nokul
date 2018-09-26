# frozen_string_literal: true

module FullNameHelper
  include EnumI18nHelper

  def full_name(object)
    case object.class.to_s
    when 'AcademicTerm'
      "#{object.year} / #{enum_t(object, :term)}"
    when 'Identity'
      "#{object.first_name} #{object.last_name}"
    end
  end
end
