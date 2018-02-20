namespace :quality do
  desc 'Runs rubocop for code quality testing'
  task :basic do
    sh 'rubocop -f fu -R -D'
  end

  desc 'Runs reek for code quality testing'
  task :detailed do
    sh 'reek'
  end

  desc 'Runs both rubocop and reek'
  task all: %w[basic detailed]
end
