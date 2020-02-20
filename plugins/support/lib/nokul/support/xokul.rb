# frozen_string_literal: true

require_relative 'xokul/configuration'
require_relative 'xokul/connection'
require_relative 'xokul/endpoint'
require_relative 'xokul/api'

module Xokul
  private_constant :Configuration

  # FIXME: Not sure how to design a configure method. That's why, see the Rails
  # source code to gain know-how about how they designed it.
  def self.configure(&block)
    return Configuration.config unless block_given?

    Configuration.configure(&block)
  end
end
