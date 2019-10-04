# frozen_string_literal: true

class UnitScope < Patron::Scope::Base
  filter :name
  filter :unit_type_id, collection: -> { UnitType.all },
                        multiple:   true,
                        i18n_key:   :unit_type

  filter :unit_status_id, collection: -> { UnitStatus.all },
                          multiple:   true,
                          i18n_key:   :unit_status

  preview_attributes :name, :names_depth_cache, :code

  dynamic_value :email, scope: :name do
    user.email
  end
end
