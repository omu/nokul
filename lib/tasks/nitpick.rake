# frozen_string_literal: true

namespace :nitpick do
  desc 'Nitpick for executables'
  task :executable do
    suspicious_executables =
      `find . -type f -executable -print | grep -Ev '^[.]/(vendor|node_modules|.git|bin|sbin|scripts)'`
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

  desc 'Runs all nitpickings'
  task all: %w[executable]
end
