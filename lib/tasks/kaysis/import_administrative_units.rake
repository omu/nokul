# frozen_string_literal: true

namespace :kaysis do
  task import_administrative_units: :environment do
    file = Rails.root.join('db', 'static_data', 'administrative_units.yml')
    abort "File not found: #{file}" unless File.exist? file
    puts 'Importing administrative units from CSV.'
    YAML.safe_load(File.read(file)).each_pair do |_, unit|
      parent =
        if unit['parent_yoksis_id']
          Unit.find_by(yoksis_id: unit['parent_yoksis_id'])
        else
          Unit.find_by(detsis_id: unit['parent_detsis_id'])
        end
      unit.shift
      unit['parent'] = parent
      Unit.create(unit)
    end
  end
end
