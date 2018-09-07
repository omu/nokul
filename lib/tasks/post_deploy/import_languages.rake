# frozen_string_literal: true

task import_languages: :environment do
  YAML.load_file(Rails.root.join('db', 'static_data', 'languages.yml')).each do |_, language|
    Language.create(language)
  end
end
