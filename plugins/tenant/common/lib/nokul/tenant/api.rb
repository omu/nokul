# frozen_string_literal: true

module Nokul
  module Tenant
    DEFAULT_TENANT = 'acme'

    mattr_accessor :name
    mattr_accessor :engine
    mattr_accessor :configuration

    alias instance engine

    module_function

    def root # rubocop:disable Rails/Delegate
      engine.root
    end

    def credentials
      Rails.application.encrypted(
        Tenant.root.join('test', 'dummy', 'config', 'credentials', "#{Rails.env}.yml.enc"), env_key: 'TENANT_MASTER_KEY'
      )
    end

    def deep_config_for(*args)
      engine.deep_config_for(*args)
    end

    def units(predication = nil)
      units = Nokul::Tenant::Units.load_source 'src/all'
      return units if predication.nil? || units.blank?

      unless units.first.respond_to?(predicator = "#{predication}?".to_sym)
        raise ArgumentError, "Unsupported unit predication: #{predication}"
      end

      units.select(&predicator)
    end

    def unit_types(category = nil)
      return units.map(&:unit_type_id).uniq.sort unless category

      unless %i[administrative academic].include? category.to_sym
        raise ArgumentError, "Unsupported unit category: #{category}"
      end

      units.select(&:"#{category}?").map(&:unit_type_id).uniq.sort
    end
  end
end
