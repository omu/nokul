# frozen_string_literal: true

require 'nokul-support'

require_relative 'tenant/version'
require_relative 'tenant/errors'
require_relative 'tenant/units'
require_relative 'tenant/api'
require_relative 'tenant/engine'

module Nokul
  module Tenant
    PLUGIN_PATTERN = 'nokul-tenant-%<name>s'

    module_function

    def load(fallback: DEFAULT_TENANT)
      tenant = self.name = (ENV['NOKUL_TENANT'] || fallback)&.downcase
      raise Error::LoadError, 'No tenant defined through NOKUL_TENANT environment' if tenant.blank?
      raise Error::LoadError, 'Tenant "common" is not a concrete tenant' if tenant == 'common'

      plugin = format PLUGIN_PATTERN, name: name

      require plugin

      return if engine

      raise Error::LoadError, "Tenant seems to be uninitialized after loading from plugin #{plugin}"
    rescue LoadError => err
      raise Error::LoadError, "Couldn't load Tenant #{tenant} from plugin #{plugin}: #{err.message}"
    end

    def initialize(engine_class)
      raise "Engine must be a Rails Engine where found: #{engine_class}" unless engine_class < ::Rails::Engine
      raise 'Only one tenant can be active' if engine

      # Fill-in Tenant.engine
      self.engine = engine_class.instance

      # Fill-in Tenant.configuration
      self.configuration = engine.deep_config_for :tenant
    end
  end
end
