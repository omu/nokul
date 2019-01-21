# frozen_string_literal: true

namespace :release do
  desc 'Bump version'
  task :bump do
    file = Rails.root.join 'app', 'lib', 'nokul', 'version.rb'
    raise "Could not locate version file #{file}" unless File.exist? file

    version = `git describe --tags $(git rev-list --tags --max-count=1)`&.chomp
    raise 'No version found from the repository' if version.blank?

    version.delete_prefix! 'v'

    ruby = File.read(file)

    ruby.gsub!(/^(\s*)VERSION(\s*)= .*?$/, "\\1VERSION = '#{version}'")
    raise "Could not insert VERSION in #{file}" unless Regexp.last_match(1)

    File.write(file, ruby)
  end
end
