# frozen_string_literal: true

# Fetch YOKSIS References
Rake::Task['fetch:references'].invoke

# import all static data
Rake::Task['import:all'].invoke

# Create a single unit_type for commissions
UnitType.create(name: 'Kurul / Komisyon', code: 200)

# Produced data for beta environment
if Rails.env.beta? || Rails.env.development?
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end

# Assign unit types to groups
UnitType.where(code: [7, 8]).update(group: 'other')
UnitType.where(code: [0, 1]).update(group: 'university')
UnitType.where(code: [5, 6, 2]).update(group: 'faculty')
UnitType.where(code: [10]).update(group: 'department')
UnitType.where(code: [13, 16, 17, 18, 19, 20, 22, 23, 24, 25]).update(group: 'program')
UnitType.where(code: 200).update(group: 'committee')
UnitType.where(code: [11, 12, 14, 15, 21]).update(group: 'major')
UnitType.where(code: [4]).update(group: 'institute')
UnitType.where(code: [9]).update(group: 'rectorship')

# Fetch Academic Staff from YOKSIS
Rake::Task['fetch:academic_staff'].invoke

# Import prospective students of 2018
Osym::ImportProspectiveStudentsJob.perform_later('db/encrypted_data/prospective_students.csv')
