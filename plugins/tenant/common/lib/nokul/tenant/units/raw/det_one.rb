# frozen_string_literal: true

# Single DETSİS unit at raw form

module Nokul
  module Tenant
    module Units
      module Raw
        class DETOne
          include Concerns::RawOne

          # Keep the order for YAML representation

          include Support::Structure.of %i[
            name
            detsis_id
            parent_administrative_identity_code
            active
            activity
          ].freeze

          def id
            detsis_id
          end

          def parent_id
            parent_administrative_identity_code
          end

          def label
            name
          end
        end
      end
    end
  end
end
