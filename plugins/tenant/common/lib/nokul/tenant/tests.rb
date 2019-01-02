# frozen_string_literal: true

%w[
  units
].each { |mod| Dir.glob(File.join(__dir__, mod, 'tests')).each { |tests| require tests } }
