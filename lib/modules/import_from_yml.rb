# frozen_string_literal: true

module ImportFromYml
  def self.parse(klass)
    file = YAML.load_file(Rails.root.join('db', 'static_data', "#{klass.tableize}.yml"))
    progress_bar = ProgressBar.spawn(klass.pluralize.to_s, file.count)

    file.each do |line|
      klass.constantize.create(line)
      progress_bar.increment
    end
  end
end
