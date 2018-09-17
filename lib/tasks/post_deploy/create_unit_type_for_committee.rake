# frozen_string_literal: true

task create_unit_type_for_committee: :environment do
  UnitType.create(name: 'Kurul / Komisyon', code: 200)
end
