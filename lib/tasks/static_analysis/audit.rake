# frozen_string_literal: true

namespace :static_analysis do
  desc 'Bundle Audit'
  task bundle_audit: :environment do
    sh 'bundle exec bundle-audit check --update --ignore CVE-2015-9284'
  end
end
