# frozen_string_literal: true

# Concern multiple units at source form

require_relative 'many'
require_relative 'abbreviatable'

module Nokul
  module Tenant
    module Units
      module Concerns
        module SrcMany
          extend ActiveSupport::Concern

          include Many
          include Abbreviatable

          def list_by(*predicators)
            select do |unit|
              predicators.none? { |predicator| !unit.send(predicator) }
            end
          end
        end
      end
    end
  end
end
