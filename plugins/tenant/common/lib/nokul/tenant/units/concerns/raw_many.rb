# frozen_string_literal: true

# Concern multiple units at raw form

require_relative 'many'

module Nokul
  module Tenant
    module Units
      module Concerns
        module RawMany
          extend ActiveSupport::Concern

          include Many

          def update
            units = (product = collection.produces).load_source

            each do |raw|
              unless (unit = units.get raw.id.to_s)
                units << (unit = product.collection.collects.new)
              end

              unit.merge_keep! raw_to_unit_hash(raw)
            end

            units
          end

          private

          def raw_to_unit_hash(raw)
            hash = {}
            mapping.each do |member, coercer|
              next unless coercer

              hash[member] = coercer.call(raw)
            end
            hash
          end
        end

        module Refinery
          FIX_AFTER_CAPITALIZE = {
            '(iö)' => '(İÖ)',
            '(yl)' => '(YL)',
            '(dr)' => '(DR)',
            'Pr.' => 'Programı',
            '(uzaktan Öğretim)' => '(Uzaktan Öğretim)',
            '(uzaktan Eğitim)' => '(Uzaktan Eğitim)'
          }.freeze

          refine String do
            def capitalize_and_fix
              capitalized = capitalize_turkish
              FIX_AFTER_CAPITALIZE.each do |find, replace|
                capitalized.gsub!(/(?<!\w)#{Regexp.escape(find)}(?!\w)/, replace)
              end
            end
          end
        end
      end
    end
  end
end
