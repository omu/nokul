# frozen_string_literal: true

require 'yaml'
require 'erb'

module Nokul
  module Tenant
    module Engine
      extend ActiveSupport::Concern

      # Stolen and modified from Rails
      def deep_config_for(name, env: Rails.env)
        unless (yaml = config_file_for(name)).exist?
          raise "Could not load configuration. No such file - #{yaml}"
        end

        config = (YAML.safe_load(ERB.new(yaml.read).result, [], [], true) || {})[env] || {}
        config.to_deep_ostruct
      rescue Psych::SyntaxError => e
        raise "YAML syntax error occurred while parsing #{yaml}. " \
          'Please note that YAML must be consistently indented using spaces. Tabs are not allowed. ' \
          "Error: #{e.message}"
      end

      def config_file_for(name)
        name.is_a?(Pathname) ? name : Pathname.new("#{paths['config'].existent.first}/#{name}.yml")
      end

      included do
        # Initialize engine (once)
        Nokul::Tenant.initialize self
      end
    end
  end
end
