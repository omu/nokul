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
      Support.abort_on_yaml_syntax_errors do
        [YOK, DET, UNI].each { |collection_class| collection_class.load.report(key) }
      end
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
