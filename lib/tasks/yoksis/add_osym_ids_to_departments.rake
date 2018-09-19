# frozen_string_literal: true

namespace :yoksis do
  desc 'Adds OSYM IDs to units'
  task add_osym_ids_to_departments: :environment do
    puts 'Adding OSYM IDs to units'

    client = Services::Yoksis::V4::UniversiteBirimler.new

    [121_946, 163_896].each do |i|
      response = client.programs(i)

      response.each do |program|
        unit = Unit.find_by(yoksis_id: program[:birim][:kod])
        unit&.update!(osym_id: program[:kilavuz_kodu])
      end
    end
  end
end
