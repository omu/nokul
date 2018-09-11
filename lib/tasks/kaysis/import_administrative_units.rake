# frozen_string_literal: true

namespace :kaysis do
  task import_administrative_units: :environment do
    file = File.open(Rails.root.join('db', 'static_data', 'administrative_units.yml'))
  rescue Errno::ENOENT => e
    puts "File/path not found! #{e}"
  else
    puts 'Importing administrative units from CSV.'
    file.read.each_line do |unit|
      parent_id, detsis_id, name, district_id = unit.split('|').map(&:strip)
      parent =
        if parent_id.length.equal?(6)
          Unit.find_by(yoksis_id: parent_id)
        elsif parent_id.length.equal?(8)
          Unit.find_by(detsis_id: parent_id)
        end

      Unit.create(
        name: name,
        detsis_id: detsis_id,
        parent: parent,
        district_id: district_id
      )
    end
  ensure
    file.close
  end
end
