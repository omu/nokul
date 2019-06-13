# frozen_string_literal: true

namespace :static_analysis do
  desc 'Scan repository for sensitive thing via git-secrets'
  task :secrets do
    sh 'command -v git-secrets >/dev/null', verbose: false do |ok|
      if ok
        sh 'git secrets --scan', verbose: false
      else
        warn 'git-secrets not found in your PATH. Skipping...'
      end
    end
  end
end
