# frozen_string_literal: true

namespace :post_deploy do
  task rebuild_terms_and_academic_terms: :environment do
    load Rails.root.join('db', 'beta_seed', 'academic_term.rb')
  end
end
