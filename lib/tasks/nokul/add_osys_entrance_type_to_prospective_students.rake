# frozen_string_literal: true

namespace :nokul do
  task add_osys_entrance_type_to_prospective_students: :environment do
    entrance_type = StudentEntranceType.find_by(code: 1)
    ProspectiveStudent.all.update(student_entrance_type_id: entrance_type.id)
  end
end
