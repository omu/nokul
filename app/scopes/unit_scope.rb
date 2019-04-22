# frozen_string_literal: true

class UnitScope < Patron::Scope::Base
  filter :name
  filter :unit_type_id, collection: -> { UnitType.all },
                        multiple: true,
                        i18n_key: :unit_type

  preview_attributes :name, :names_depth_cache
end
