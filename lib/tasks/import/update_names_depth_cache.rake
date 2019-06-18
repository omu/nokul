# frozen_string_literal: true

namespace :import do
  desc 'Update names_depth_cache fields of units'
  task update_names_depth_cache: :environment do
    progress_bar = ProgressBar.spawn('Update names_depth_cache', Unit.count)
    
    Unit.all.each do |unit|
      unit.save
      progress_bar&.increment
    end
  end
end
