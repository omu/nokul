# frozen_string_literal: true

require 'support'

YOK = Class.new Tenant::Units do
  collection.source   = 'db/src/yok.yml'
  collection.label    = 'YÖKSİS birimleri'
end

DET = Class.new Tenant::Units do
  collection.source   = 'db/src/det.yml'
  collection.label    = 'DETSİS birimleri'
end

UNI = Class.new Tenant::Units do
  collection.source   = 'db/src/uni.yml'
  collection.label    = 'Üniversiteye özgü birimler'
end

ALL = Class.new Tenant::Units do
  collection.source   = 'db/units.yml'
  collection.label    = 'Tüm birimler'

  collection.coder    = 'config/coding.yml'
end

module Common
  def headline
    puts "====> #{collection.label} (Source: #{collection.source})"
    puts ''
  end
end

[YOK, DET, UNI, ALL].each { |collection_class| collection_class.include Common }

namespace :tenant do
  desc 'Default task for units'
  task units: %w[units:stats]
end
