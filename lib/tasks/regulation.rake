# frozen_string_literal: true

namespace :regulation do
  desc 'Upsert regulations'
  task upsert: :environment do
    Extensions::Regulation::Loader.call

    Extensions::Regulation::Base.descendants.each do |regulation|
      record = Regulation.find_or_initialize_by(class_name: regulation.name)
      record.assign_attributes(
        effective_date: regulation.effective_date,
        repealed_at:    regulation.repealed_at
      )
      record.save!
    end
  end
end
