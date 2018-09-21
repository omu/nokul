# frozen_string_literal: true

namespace :post_deploy do
  task create_unit_type_for_committee: :environment do
    UnitType.create(name: 'Kurul / Komisyon', code: 200)
  end
end
