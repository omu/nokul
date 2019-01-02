# frozen_string_literal: true

# DETSİS units at raw form

module Nokul
  module Tenant
    module Units
      module Raw
        class DETMany < Support::UniqCollection
          include Concerns::RawMany
          using   Concerns::Refinery

          collection.source   = 'db/units/raw/det.yml'
          collection.label    = 'DETSİS ham birimler'
          collection.collects = DETOne
          collection.produces = Src::DETMany

          # rubocop:disable Layout/AlignHash
          class_attribute :mapping, default: {
            name:                         proc { |raw| raw.name.split('>').last&.titleize },
            detsis_id:                    proc { |raw| raw.detsis_id&.to_s },
            parent_detsis_id:             proc { |raw| raw.parent_detsis_id&.to_s },

            unit_status_id:               proc do |raw|
              next 'Aktif'      if raw.active &&  raw.activity
              next 'Yarı Pasif' if raw.active && !raw.activity

              'Pasif'
            end
          }.freeze
          # rubocop:enable Layout/AlignHash

          END_POINT = 'https://api.omu.sh/detsis/units'

          def self.fetch
            root_id = config.fetching.det.root_id
            File.write Tenant.root.join(collection.source), create.fetch(root_id).as_canonical_yaml_string
          end

          def fetch(root_id)
            produce_units.each do |unit|
              unit.parent_detsis_id = 0 if unit.detsis_id.to_s == root_id.to_s
              populate(unit)
            end

            self
          end

          def produce_units
            response = Xokul.request(END_POINT)
            return [] unless response.ok?

            [response.decode || []].flatten.map! do |args|
              self.class.collects.new(**args.symbolize_keys)
            end
          rescue Net::HTTPError
            []
          end

          def populate(unit)
            self << unit
            puts format("%<number>4d\t%<label>s", number: size, label: unit.label)
            unit
          end
        end
      end
    end
  end
end
