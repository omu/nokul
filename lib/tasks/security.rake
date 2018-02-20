namespace :security do
  desc 'Runs brakeman for vulnerabilities'
  task :brakeman do
    sh 'bundle exec brakeman -q'
  end

  desc 'Checks dependencies and vulnerabilities'
  task :audit do
    sh 'bundle audit check --update'
  end

  desc 'Runs all security tasks'
  task all: %w[brakeman audit]
end
