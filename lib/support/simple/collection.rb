# frozen_string_literal: true

require 'delegate'

module Simple
  class Collection < SimpleDelegator
    class Error < StandardError; end

    # :reek:Attribute
    attr_accessor :property

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

    def self.new_with_properties(items, **property)
      (collection = new items).property = ActiveSupport::InheritableOptions.new(**property)
      collection
    end

    def self.from_hashes(hashes, **properties)
      raise Error, 'All collection items must be hash' unless hashes.all? { |hash| hash.is_a? Hash }

      items = hashes.map { |hash| collects.new(**hash.symbolize_keys) }
      new_with_properties items, **properties
    end

    def self.to_hashes(instance)
      instance.map { |item| item.to_h.stringify_keys }
    end

    def self.from_yaml(yaml)
      from_hashes(YAML.safe_load(yaml) || {})
    end

    def self.read_from_yaml_file(file)
      from_hashes(YAML.load_file(file) || {}, source: file)
    end

    def self.to_yaml(instance)
      hashes = to_hashes(instance)
      content = hashes.to_yaml
      content.gsub!(/\s+$/, '')
      content.gsub!("\n-", "\n\n-")
      content << "\n"
    end

    def self.write_to_yaml_file(file, instance, comment: nil)
      yaml = (comment ? "# #{comment}\n" : '') + to_yaml(instance)
      Support.with_backup_and_notification(file) { File.write file, yaml }
    end

    def __setobj__(obj)
      raise Error, 'Construction argument must be an Array' unless obj.is_a? Array

      @delegate_sd_obj = obj
    end
  end
end
