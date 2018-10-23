# frozen_string_literal: true

namespace :import do
  desc 'Imports countries from yaml'
  task countries: :environment do
    Support.create_entities_from_yaml('Country')
  end
end
