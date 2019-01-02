# frozen_string_literal: true

module Nokul
  module Tenant
    mattr_accessor :engine

    alias instance engine

    module_function

    def initialize(engine_class)
      raise "Engine must be a Rails Engine where found: #{engine_class}" unless engine_class < ::Rails::Engine
      raise 'Only one tenant can be active' if defined? Nokul::Tenant::Active

      Nokul::Tenant.const_set :Active, engine_class
      self.engine = engine_class.instance
    end

    def deep_config_for(*args)
      engine.deep_config_for(*args)
    end

    def root
      engine.root
    end
  end
end
