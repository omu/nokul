# frozen_string_literal: true

Rake::Task['fetch:references'].invoke # fetch YOKSIS references
Rake::Task['import:all'].invoke # import common static data

# Produced data for beta environment
if Rails.env.beta? || Rails.env.development?
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end

# Fetch Academic Staff from YOKSIS
Rake::Task['fetch:academic_staff'].invoke unless Rails.env.development?

# Import prospective students of 2018
Osym::ImportProspectiveStudentsJob.perform_later('db/encrypted_data/prospective_students.csv')
