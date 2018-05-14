# frozen_string_literal: true

json.array! @academic_terms, partial: 'calendar/academic_terms/academic_term', as: :academic_term
