# frozen_string_literal: true

# Fetch YOKSIS References
Rake::Task['fetch:references'].invoke

# import all static data
Rake::Task['import:all'].invoke

# Create a single unit_type for commissions
UnitType.create(name: 'Kurul / Komisyon', code: 200)

# Import prospective students of 2018
Osym::ImportProspectiveStudentsJob.perform_later

# Produced data for beta environment
if Rails.env.beta? || Rails.env.development?
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end

# Fetch Academic Staff from YOKSIS
Rake::Task['fetch:academic_staff'].invoke
