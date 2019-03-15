# frozen_string_literal: true

module Nokul
  class Version
    attr_reader :major, :minor, :patch

    def initialize(*version)
      @major, @minor, @patch = version
    end

    def self.current
      if File.exist?(manifest = Rails.root.join('app.json'))
        current_version = JSON.parse(File.read(manifest)).fetch('version')
        Version.new(*current_version.split('.')).to_s
      else
        '0.0.0'
      end
    end

    def to_s
      "%d.%d.%d" % [@major, @minor, @patch]
    end
  end
end
