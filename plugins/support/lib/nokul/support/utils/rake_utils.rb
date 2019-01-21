# frozen_string_literal: true

module Nokul
  module Support
    module_function

    def create_entities_from_yaml(entity_class, basepath = Rails.root.join('db', 'static_data'))
      file = YAML.load_file(basepath.join("#{entity_class.tableize}.yml"))
      progress_bar = ProgressBar.spawn(entity_class.pluralize.to_s, file.count)

      file.each do |line|
        entity_class.constantize.create(line)
        progress_bar&.increment
      end
    end
  end
end
