# frozen_string_literal: true

module Nokul
  module Tenant
    DEFAULT_TENANT = 'omu'

    mattr_accessor :name
    mattr_accessor :engine
    mattr_accessor :configuration

    alias instance engine

    module_function

    def root # rubocop:disable Lint/UnneededCopDisableDirective,Rails/Delegate
      engine.root
    end

    def credentials
      Rails.application.encrypted(
        Tenant.root.join('test', 'dummy', 'config', 'credentials.yml.enc'), env_key: 'TENANT_MASTER_KEY'
      )
    end

    def deep_config_for(*args)
      engine.deep_config_for(*args)
    end

    def units(predication = nil)
      units = Nokul::Tenant::Units.load_source 'src/all'
      return units if predication.nil? || units.blank?

      unless units.first.respond_to?(predicator = "#{predication}?".to_sym)
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
