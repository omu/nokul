# frozen_string_literal: true

module FullNameHelper
  include I18nHelper

  # rubocop:disable Metrics/AbcSize
  def full_name(object)
    case object.class.to_s
    when 'AcademicTerm'
      "#{object.year} / #{enum_t(object, :term)}"
    when 'Identity'
      "#{object.first_name} #{object.last_name}"
    when 'Employee'
      formal_identity = object.identities.formal
      if formal_identity.present?
        "#{object.title_name} #{formal_identity.first.first_name} #{formal_identity.first.last_name}"
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
