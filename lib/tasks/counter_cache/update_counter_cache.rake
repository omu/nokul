# frozen_string_literal: true

desc 'Counter cache for number of articles/projects a user have'

namespace :update_counter_cache do
  task article_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :articles) }
  end

  task project_counter: :environment do
    User.find_each { |user| User.reset_counters(user.id, :projects) }
  end
end
