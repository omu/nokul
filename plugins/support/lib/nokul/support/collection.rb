# frozen_string_literal: true

require 'delegate'
require 'yaml'

require 'active_support/inflections'

module Nokul
  module Support
    class Collection < SimpleDelegator
      class Error < StandardError; end

      class_attribute :collection, default: ActiveSupport::OrderedOptions.new

      def self.inherited(child)
        child.collection = collection.dup

        return unless (name = child.name) # might be an anonymous class
        return if (singular_name = ActiveSupport::Inflector.singularize(name)) == name

        # rubocop:disable Style/RescueModifier
        child.collection.collects = singular_name.constantize rescue nil
        # rubocop:enable Style/RescueModifier
      end

      def self.collects
        raise Error, "Couldn't determine collection item class" unless (item_class = collection.collects)

        item_class
      end

      def self.canonicalize_hashes(hashes)
        raise Error, 'All collection items must be hash' unless hashes.all? { |hash| hash.is_a? Hash }

        hashes.map { |hash| collects.new(**hash.symbolize_keys) }
      end

      def self.create(hashes = [])
        new canonicalize_hashes hashes
      end

      def self.create_from_yaml(yaml)
        create(YAML.safe_load(yaml) || {})
      end

      def self.read_from_yaml_file(file)
        hashes = File.exist?(file) ? YAML.load_file(file) || [] : []
        (instance = create(hashes)).collection.source = file
        instance
      end

      def self.to_yaml_pretty(instance)
        instance.map { |item| item.to_h.stringify_keys }.to_yaml_pretty
      end

      def self.write_to_yaml_file(file, instance, comment: nil)
        yaml  = comment ? comment.gsub(/^/m, '# ') : ''
        yaml += to_yaml_pretty(instance)
        Support.with_status_and_notification(file) { File.write file, yaml }
      end

      def get(by)
        return if empty?

        unless (@lookup ||= {}).key? by
          __ensure_lookup__
          @lookup = index_by(&:id)
        end

        @lookup.fetch(by, nil)
      end

      def __ensure_lookup__
        return if all? { |item| item.respond_to? :id }

        raise Error, 'All items must have id method for lookup'
      end

      def __ensure_construction__
        return @delegate_sd_obj if @delegate_sd_obj.is_a? Array

        raise Error, "Construction argument must be an Array where found #{@delegate_sd_obj.class}"
      end

      def __setobj__(obj)
        @delegate_sd_obj = obj
        __ensure_construction__
      end
    end
  end
end
