# frozen_string_literal: true

class AddNamedDepthCacheToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :names_depth_cache, :string, limit: 255
  end
end
