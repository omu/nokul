# frozen_string_literal: true

# Aggregated units at source form

module Nokul
  module Tenant
    module Units
      module Src
        class ALLMany < Support::UniqCollection
          include Concerns::SrcMany

          collection.source   = 'db/units/src/all.yml'
          collection.label    = 'Tüm birimler'
          collection.collects = ALLOne

          def code(old_units)
            Tenant::Units::Coder.code new_units: self, old_units: old_units, config: self.class.config.coding
            self
          end

          def produce
            all_units = self.class.create [
              *Tenant::Units.load_source('src/yok').map(&:to_h),
              *Tenant::Units.load_source('src/det').map(&:to_h),
              *Tenant::Units.load_source('src/uni').map(&:to_h)
            ]
            all_units.code self
          end
        end
      end
    end
  end
end
