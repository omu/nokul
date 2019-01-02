# frozen_string_literal: true

# YÖKSİS units at source form

module Nokul
  module Tenant
    module Units
      module Src
        class YOKMany < Support::UniqCollection
          include Concerns::SrcMany

          collection.source   = 'db/units/src/yok.yml'
          collection.label    = 'YÖKSİS birimleri'
          collection.collects = YOKOne
        end
      end
    end
  end
end
