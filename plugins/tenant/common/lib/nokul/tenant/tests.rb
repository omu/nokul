# frozen_string_literal: true

%w[
  units
].each { |mod| Dir.glob(File.join(__dir__, mod, 'tests')).sort.each { |tests| require tests } }
