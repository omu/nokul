# frozen_string_literal: true

namespace :import do
  desc 'Imports titles from db/static_data'
  task titles: :environment do
    ImportFromYml.parse('Title')
  end
end
