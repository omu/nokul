# frozen_string_literal: true

namespace :nokul do
  desc 'Archive prospective students if expiry date has passed'
  task archive_prospective_students: :environment do
    ProspectiveStudent.not_archived.find_each { |ps| ps.update(archived: true) if ps.expiry_date < Time.zone.now }
  end
end
