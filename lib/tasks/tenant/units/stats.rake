# frozen_string_literal: true

module Statsable
  FORMATTER = proc { |**param| format('%<label>36s: %<number>d', **param) }

  def stats
    headline

    collect_statistics_by_predicators

    puts ''
    puts FORMATTER.call label: 'Toplam birim sayısı', number: size
    puts ''
  end

  def collect_statistics_by_predicators
    Tenant::Unit::Predicators.predicators.each do |predicator, label|
      number = list_by(predicator)&.size
      puts FORMATTER.call label: label, number: number
    end
  end
end

[YOK, DET, UNI].each { |collection_class| collection_class.include Statsable }

namespace :tenant do
  namespace :units do
    desc 'Display statistics'
    task :stats do
      Support.abort_on_yaml_syntax_errors do
        [YOK, DET, UNI].each { |collection_class| collection_class.load.stats }
      end
    end
  end
end
