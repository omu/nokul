namespace :quality do
  desc 'Runs Ruby specific code quality testing'
  task :ruby do
    sh 'rubocop -f fu -D'
    sh 'reek'
  end

  desc 'Runs Rails specific code quality testing'
  task :rails do
    sh 'rubocop -f fu -R -D'
    sh 'rubycritic --format console'
  end

  desc 'Runs both rubocop and reek'
  task all: %w[ruby rails]
end
