# frozen_string_literal: true

module SuspiciousExecutable
  PATTERN        = '^[.]/([.]git|vendor|node_modules|tmp|log|bin|sbin|scripts)'
  FIXING_MESSAGE = <<~MESSAGE
    Please fix the issue by one of the following methods:

      - Remove the executable bits with the "chmod -x" command and commit changes.
      - Move the files to the toplevel bin, sbin or scripts directory.
  MESSAGE

  def self.find
    found = `find . -type f -executable -print | grep -Ev '#{PATTERN}'`
    found.lines.reject do |filename|
      File.read(filename.chomp).start_with?('#!')
    end
  end
end

namespace :static_analysis do
  desc 'Detect suspicious executables'
  task :executables do
    suspicious_executables = SuspiciousExecutable.find

    next warn 'No suspicious files found. Yay!' if suspicious_executables.empty?

    warn 'Files with the executable bit set found:'

    warn ''
    suspicious_executables.each do |filename|
      warn "\t#{filename}"
    end
    warn ''

    warn SuspiciousExecutable::FIXING_MESSAGE
  end
end
