# frozen_string_literal: true

namespace :nokul do
  desc 'Archive prospective students if expiry date has passed'
  task archive_prospective_students: :environment do
    expiry_date = ProspectiveStudent.arel_table[:expiry_date]
    ProspectiveStudent.not_archived.where(expiry_date.lt(Time.zone.now)).update(archived: true)
  end
end
