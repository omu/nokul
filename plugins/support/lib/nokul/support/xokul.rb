# frozen_string_literal: true

require_relative 'xokul/configuration'
require_relative 'xokul/connection'
require_relative 'xokul/endpoint'
require_relative 'xokul/api'

module Xokul
  private_constant :Configuration

  def self.configure
    yield Configuration.config if block_given?
  end
end
