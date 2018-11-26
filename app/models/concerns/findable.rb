# frozen_string_literal: true

class Findable < Module
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def initialize(definition_file)
    extend ActiveSupport::Concern

    included do
      findable = ActiveSupport::OrderedOptions.new

      YAML.load_file(definition_file).each do |category, data|
        data.each do |datum|
          thing = Thing.new(path: [category], **datum.deep_symbolize_keys)
          findable[thing.ident] = thing
        end
      end

      class_attribute :findable, default: findable
    end

    class_methods do
      class_eval do
        def find_by_identifier(ident)
          find_by(name: findable[ident].title)
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  class Thing
    attr_reader :path, :name, :title, :ident

    def initialize(path:, name:, title:)
      @path  = path
      @name  = name
      @title = title
      @ident = build_identity
    end

    protected

    PATH_SEPARATOR = '_'

    def build_identity
      [*path, name].map(&:to_s).join PATH_SEPARATOR
    end
  end
end
