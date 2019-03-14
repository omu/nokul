# frozen_string_literal: true

namespace :nokul do
  desc 'Archive prospective students if expiry date has passed'
  task archive_prospective_students: :environment do
    prospective_students = ProspectiveStudent.arel_table

    ProspectiveStudent.not_archived.where(prospective_students[:expiry_date].lt(Time.zone.now)).update(archived: true)
  end
end
