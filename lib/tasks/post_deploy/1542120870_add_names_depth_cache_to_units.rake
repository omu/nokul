# frozen_string_literal: true

namespace :post_deploy do
  task add_names_depth_cache_to_units: :environment do
    Unit.all.each(&:save!)
  end
end
