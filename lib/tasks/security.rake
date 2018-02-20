namespace :security do
  desc 'Runs brakeman for vulnerabilities'
  task :brakeman do
    sh 'bundle exec brakeman -q'
  end

  desc 'Runs all security tasks'
  task all: %w[brakeman]
end
