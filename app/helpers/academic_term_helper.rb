# frozen_string_literal: true

module AcademicTermHelper
  def years
    Time.zone.now.year.downto(1975).map { |year| "#{year} - #{year + 1}" }
  end

  def academic_term_full_name(academic_term)
    "#{academic_term.year} / #{enum_t(academic_term, :term)}"
  end
end
