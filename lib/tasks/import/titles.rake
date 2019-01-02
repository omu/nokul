# frozen_string_literal: true

namespace :import do
  desc 'Imports titles from yaml'
  task titles: :environment do
    Nokul::Support.create_entities_from_yaml('Title')
  end
end
