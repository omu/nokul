# frozen_string_literal: true

namespace :static_analysis do
  desc 'Scan repository for sensitive thing via git-secrets'
  task :secrets do
    if find_executable('git-secrets')
      sh 'git secrets --scan', verbose: false
    else
      warn 'git-secrets not found in your PATH. Skipping...'
    end
  end
end
