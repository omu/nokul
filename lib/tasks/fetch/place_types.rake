# frozen_string_literal: true

namespace :fetch do
  desc 'Fetch place types from Meksis'
  task place_types: :environment do
    parents  = Xokul::Meksis.parent_place_types
    children = Xokul::Meksis.sub_place_types

    progress_bar = ProgressBar.spawn 'Meksis - Place Types', (parents + children).size

    parents.each do |place|
      PlaceType.create(meksis_id: place[:id], name: place[:name])
      progress_bar&.increment
    end

    children.each do |place|
      parent = PlaceType.find_by(meksis_id: place[:parent_id])
      PlaceType.create(meksis_id: place[:id], name: place[:name], parent: parent)
      progress_bar&.increment
    end
  end
end
