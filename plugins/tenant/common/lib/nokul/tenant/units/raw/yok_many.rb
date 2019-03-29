# frozen_string_literal: true

# YÖKSİS units at raw form

module Nokul
  module Tenant
    module Units
      module Raw
        class YOKMany < Support::UniqCollection
          include Concerns::RawMany
          using   Concerns::Refinery

          collection.source   = 'db/units/raw/yok.yml'
          collection.label    = 'YÖKSİS ham birimler'
          collection.collects = YOKOne
          collection.produces = Src::YOKMany
          class_attribute :mapping, default: {
            name:                         proc { |raw| raw.long_name.split('/').last&.capitalize_and_fix },

            yoksis_id:                    proc { |raw| raw.unit_code&.to_s },
            parent_yoksis_id:             proc { |raw| raw.parent_unit_id&.to_s },
            district_id:                  proc { |raw| raw.district_name&.capitalize_and_fix },

            osym:                         proc { |raw| raw.osym_id&.to_s },
            unit_type_id:                 proc { |raw| raw.unit_type_name&.capitalize_and_fix },
            unit_status_id:               proc { |raw| raw.status_name&.capitalize_and_fix },
            unit_instruction_language_id: proc { |raw| raw.instruction_language_name&.capitalize_and_fix },
            unit_instruction_type_id:     proc { |raw| raw.instruction_type_name&.capitalize_and_fix },
            duration:                     proc { |raw| raw.period_of_study }
          }.freeze

          END_POINT = 'https://api.omu.sh/yoksis/units/%s'

          def self.fetch
            root_id = config.fetching.yok.root_id
            File.write Tenant.root.join(collection.source), create.fetch(root_id).as_canonical_yaml_string
          end

          def fetch(root_id)
            return unless fetch_root(id = root_id.to_i)

            fetch_all_programs_and_their_subunits(id)
            fetch_all_subunits(id)

            self
          end

          private

          def fetch_root(root_id)
            return unless (root_unit = unit(root_id))

            root_unit.parent_unit_id = 0 # mark root unit

            populate root_unit
          end

          def fetch_all_programs_and_their_subunits(id)
            uniquify(programs(id)).each do |unit|
              populate unit
              fetch_all_subunits(unit.unit_code)
            end
          end

          def fetch_all_subunits(id)
            uniquify(subunits(id)).each do |unit|
              populate unit
              fetch_all_subunits(unit.unit_code)
            end
          end

          def produce_units_from_end_point(end_point:, id:)
            response = Xokul.request(END_POINT % end_point, unit_id: id)
            return [] unless response.ok?

            [response.decode || []].flatten.map! do |args|
              self.class.collects.new(**args.symbolize_keys)
            end
          rescue Net::HTTPError
            []
          end

          def uniquify(units)
            [*units].reject { |unit| include? unit }
          end

          def populate(unit)
            self << unit
            puts format("%<number>4d\t%<label>s", number: size, label: unit.label)
            unit
          end

          def unit(id)
            produce_units_from_end_point(end_point: 'names', id: id)&.first
          end

          def subunits(id)
            produce_units_from_end_point(end_point: 'subunits', id: id)
          end

          def programs(id)
            produce_units_from_end_point(end_point: 'programs', id: id)
          end
        end
      end
    end
  end
end
