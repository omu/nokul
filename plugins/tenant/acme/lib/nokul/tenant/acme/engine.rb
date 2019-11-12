# frozen_string_literal: true

require 'nokul-tenant'

module Nokul
  module Tenant
    module ACME
      class Engine < ::Rails::Engine
        include Tenant::Engine
      end
    end
  end
end
