# frozen_string_literal: true

require 'nokul-support'

require_relative 'tenant/version'
require_relative 'tenant/errors'
require_relative 'tenant/initialize'
require_relative 'tenant/engine'
require_relative 'tenant/units'

module Nokul
  module Tenant
    DEFAULT_TENANT = 'omu'
    GEM_PREFIX     = 'nokul-tenant-'

    mattr_accessor :name

    module_function

    def plugin_for(name)
      "#{GEM_PREFIX}#{name}"
    end

    def load(fallback: DEFAULT_TENANT)
      tenant = self.name = (ENV['NOKUL_TENANT'] || fallback)&.downcase
      raise Error::LoadError, 'No tenant defined through NOKUL_TENANT environment' if tenant.blank?
      raise Error::LoadError, 'Tenant "common" is not a concrete tenant' if tenant == 'common'

      plugin = plugin_for tenant

      require plugin
    rescue LoadError => err
      raise Error::LoadError, "Couldn't load Tenant #{tenant} from plugin #{plugin}: #{err.message}"
    end
  end
end
