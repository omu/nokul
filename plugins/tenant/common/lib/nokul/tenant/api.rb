# frozen_string_literal: true

module Nokul
  module Tenant
    DEFAULT_TENANT = 'omu'

    mattr_accessor :name
    mattr_accessor :engine
    mattr_accessor :configuration

    module_function

    def deep_config_for(*args)
      engine.deep_config_for(*args)
    end

    # rubocop:disable Rails/Delegate
    def root
      engine.root
    end
    # rubocop:enable Rails/Delegate

    alias instance engine

    def units
      Nokul::Tenant::Units.load_source 'src/all'
    end

    def unit_types(type = nil)
      return units.map(&:unit_type_id).uniq.sort unless type

      units.select(&:"#{type}?").map(&:unit_type_id).uniq.sort
    end
  end
end
