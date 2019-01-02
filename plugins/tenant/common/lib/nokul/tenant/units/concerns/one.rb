# frozen_string_literal: true

# Concern a single unit at any form

module Nokul
  module Tenant
    module Units
      module Concerns
        module One
          extend ActiveSupport::Concern

          include Support::Structure.of %i[
            name
          ]

          # Required to use as a UniqCollection (a Set) having a tree structure

          def id
            raise NotImplementedError
          end

          def parent_id
            raise NotImplementedError
          end

          def eql?(other)
            other.eql? id
          end

          def hash
            id.hash
          end

          def to_s
            "\e[1m#{id}\e[0m  #{name}"
          end
        end
      end
    end
  end
end
