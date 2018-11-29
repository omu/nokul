# frozen_string_literal: true

namespace :post_deploy do
  task remove_calendar_titles: :environment do
    CalendarTitle.destroy_all
  end
  task configure_calendar_titles: :environment do
    load Rails.root.join('db', 'beta_seed', 'calendar.rb')
  end
end
