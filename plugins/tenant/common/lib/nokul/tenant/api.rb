# frozen_string_literal: true

module Nokul
  module Tenant
    DEFAULT_TENANT = 'omu'

    mattr_accessor :name
    mattr_accessor :engine
    mattr_accessor :configuration

    alias instance engine

    module_function

    # rubocop:disable Rails/Delegate
    def root
      engine.root
    end
    # rubocop:enable Rails/Delegate

    def deep_config_for(*args)
      engine.deep_config_for(*args)
    end

    def units(predication = nil)
      units = Nokul::Tenant::Units.load_source 'src/all'
      return units unless predication

      unless Nokul::Tenant::Units::Concerns::Predicable.method_defined?(predicator = "#{predication}?".to_sym)
        raise "Unsupported unit predication: #{predication}"
      end

      units.select(&predicator)
    end

    def unit_types(category = nil)
      return units.map(&:unit_type_id).uniq.sort unless category

      raise "Unsupported unit category: #{category}" unless %i[administrative academic].include? category.to_sym

      units.select(&:"#{category}?").map(&:unit_type_id).uniq.sort
    end
  end
end
