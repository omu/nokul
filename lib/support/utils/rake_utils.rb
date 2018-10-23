# frozen_string_literal: true

module Support
  module_function

  def create_entities_from_yaml(entity_class, filename: nil, basepath: Rails.root.join('db', 'static_data'))
    filename ||= entity_class.tableize
    file = YAML.load_file(basepath.join("#{filename}.yml"))
    progress_bar = ProgressBar.spawn(entity_class.pluralize.to_s, file.count)

    file.each do |line|
      entity_class.constantize.create(line)
      progress_bar&.increment
    end
  end
end
