# frozen_string_literal: true

namespace :quality do
  desc 'Runs Rails specific code quality testing'
  task :rails do
    sh 'bundle exec rubocop -f fu -R -D'
  end

  desc 'Checks for suspicious executables'
  task :executables do
    suspicious_executables =
      `find . -type f -executable -print | grep -Ev '^[.]/([.]git|vendor|node_modules|tmp|log|bin|sbin|scripts)'`
      .split("\n").reject do |filename|
        File.open(filename).first.start_with? '#!'
      end

    next if suspicious_executables.empty?

    warn 'Files with the executable bit set found:'

    warn ''
    suspicious_executables.each do |filename|
      warn "\t#{filename}"
    end
    warn ''

    warn <<~ERR
      Please fix the issue by one of the following methods:

      - Remove the executable bits with the "chmod -x" command and commit changes.

      - Move the files to the toplevel bin, sbin or scripts directory.
    ERR

    abort
  end

  desc 'Runs all quality tasks'
  task all: %w[rails executables]
end
