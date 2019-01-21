# frozen_string_literal: true

# Concern a single unit at raw form

require_relative 'one'

module Nokul
  module Tenant
    module Units
      module Concerns
        module RawOne
          extend ActiveSupport::Concern

          include One
        end
      end
    end
  end
end
