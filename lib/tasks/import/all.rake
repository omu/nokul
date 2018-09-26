# frozen_string_literal: true

namespace :import do
  desc 'Runs all static data importing tasks'
  task all: %w[
    countries
    yoksis_country_codes
    cities
    districts
    languages
    titles
    high_school_types
    units
    administrative_units
  ]
end
