# frozen_string_literal: true

# Custom university units at source form

module Nokul
  module Tenant
    module Units
      module Src
        class UNIMany < Support::UniqCollection
          include Concerns::SrcMany

          collection.source   = 'src/db/units/uni.yml'
          collection.label    = 'Üniversiteye özgü birimler'
          collection.collects = UNIOne
        end
      end
    end
  end
end
