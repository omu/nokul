# frozen_string_literal: true

namespace :fetch do
  desc 'Fetch buildings from Meksis'
  task buildings: :environment do
    buildings = Xokul::Meksis.buildings

    progress_bar = ProgressBar.spawn 'Meksis - Buildings', buildings.size

    buildings.each do |building|
      place_type = PlaceType.find_by(meksis_id: building[:main_place_type_id])
      unit = Unit.find_by(yoksis_id: building[:unit_id])

      record = Building.find_or_initialize_by(meksis_id: building[:id])
      record.assign_attributes(
        meksis_id:   building[:id],
        name:        building[:name],
        code:        building[:code],
        indoor_area: building[:indoor_area],
        active:      building[:active],
        place_type:  place_type,
        unit:        unit
      )
      record.save
      
      progress_bar&.increment
    end
  end
end
