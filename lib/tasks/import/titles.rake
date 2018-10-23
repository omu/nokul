# frozen_string_literal: true

namespace :import do
  desc 'Imports titles from yaml'
  task titles: :environment do
    Support.create_entities_from_yaml('Title')
  end
end
