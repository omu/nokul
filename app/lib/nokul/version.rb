# frozen_string_literal: true

module Nokul
  class Version < Gem::Version
    def self.load_from_manifest
      version = if File.exist?(manifest = Rails.root.join('app.json'))
                  JSON.parse(File.read(manifest)).fetch('version')
                end
      new(version || '0.0.0')
    end

    def self.current
      @current ||= load_from_manifest.to_s
    end
  end
end
