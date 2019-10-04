# frozen_string_literal: true

namespace :fetch do
  desc 'Fetch classrooms from Meksis'
  task classrooms: :environment do
    Building.all.each do |building|
      classrooms = Xokul::Meksis.classrooms(building.meksis_id)
      next if classrooms.empty?

      progress_bar = ProgressBar.spawn 'Meksis - Classroom', classrooms.size

      classrooms.each do |classroom|
        place_type = PlaceType.find_by(meksis_id: classroom[:sub_place_type_id])

        record = Classroom.find_or_initialize_by(meksis_id: classroom[:id])
        record.assign_attributes(
          name:             classroom[:name],
          code:             classroom[:code],
          room_number:      classroom[:room_number],
          student_capacity: classroom[:capacity],
          exam_capacity:    classroom[:exam_capacity],
          length:           classroom[:height],
          width:            classroom[:width],
          volume:           classroom[:volume],
          height:           classroom[:elevation],
          available_space:  classroom[:available_space],
          building:         building,
          place_type:       place_type
        )
        record.save

        progress_bar&.increment
      end
    end
  end
end
