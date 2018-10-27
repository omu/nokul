# frozen_string_literal: true

module Reportable
  def report(key)
    headline

    each do |unit|
      values = unit.send key
      next if values.blank?

      puts unit.name
      values.each { |value| puts "\t- #{value}" }
      puts ''
    end
  end
end

[YOK, DET, UNI].each { |collection_class| collection_class.include Reportable }

namespace :tenant do
  namespace :units do
    def run(key)
      [YOK, DET, UNI].each { |collection_class| collection_class.load.report(key) }
    end

    desc 'Display issues'
    task :issues do
      run :issues
    end

    desc 'Display notes'
    task :notes do
      run :notes
    end
  end
end
