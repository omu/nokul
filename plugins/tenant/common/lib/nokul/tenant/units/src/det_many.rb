# frozen_string_literal: true

# DETSİS units at source form

module Nokul
  module Tenant
    module Units
      module Src
        class DETMany < Support::UniqCollection
          include Concerns::SrcMany

          collection.source   = 'db/units/src/det.yml'
          collection.label    = 'DETSİS birimleri'
          collection.collects = DETOne
        end
      end
    end
  end
end
