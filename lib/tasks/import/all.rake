# frozen_string_literal: true

namespace :import do
  desc 'Runs all static data importing tasks'
  task all: %w[
    countries
    yoksis_countries
    cities
    districts
    languages
    titles
    high_school_types
    detsis_unit_types
    unit_groups
    units
    update_names_depth_cache
  ]
end
