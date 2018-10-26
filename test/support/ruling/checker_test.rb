# frozen_string_literal: true

require 'test_helper'

class RulingCheckerTest < ActiveSupport::TestCase
  class NameSafeRule < Ruling::Rule
    synopsis 'İsimlerde güvensiz karakterler olmamalı'
    subject :name

    rule 'no Turkish character' do
      spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
    end
  end

  test 'basic use case should just work' do
    names = %w[
      recai
      serhat
      hüseyin
      irfan
    ]

    checker = Ruling::Checker.new names
    violations = checker.check NameSafeRule

    assert_equal 1, violations.size
    assert violations.first.is_a? Ruling::Violation
    assert_match(/no Turkish character: hüseyin/, violations.first.to_s)
  end

  class NameExtraSafeRule < Ruling::Rule
    synopsis 'İsimlerde güvensiz karakterler olmamalı'
    subject :name

    rule 'no Turkish character' do
      spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
    end

    rule 'no space character' do
      spot if name =~ /\s/
    end
  end

  test 'should stop checking rule on first violation' do
    names = %w[
      recai
      serhat
      hüseyin
      irfan
    ]
    names << 'ayşe begüm'

    checker = Ruling::Checker.new names
    violations = checker.check NameExtraSafeRule

    assert_equal 2, violations.size
    assert_match(/no Turkish character: hüseyin/, violations.first.to_s)
    assert_match(/no Turkish character: ayşe begüm/, violations.second.to_s)
  end

  class NameSafeWithContextRule < Ruling::Rule
    synopsis 'İsimlerde güvensiz karakterler olmamalı'
    subject :name

    def self.setup(context)
      context.seen = {}
    end

    rule 'no Turkish character' do
      spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
    end

    rule 'no space character' do
      spot if name =~ /\s/
    end

    rule 'must be unique' do |context|
      spot if (seen = context.seen)[name]
      seen[name] = true
    end
  end

  test 'basic use case with context should just work' do
    names = %w[
      recai
      serhat
      hüseyin
      irfan
      recai
    ]

    checker = Ruling::Checker.new names
    violations = checker.check NameSafeWithContextRule

    assert_equal 2, violations.size
    assert_match(/no Turkish character: hüseyin/, violations.first.to_s)
    assert_match(/must be unique: recai/, violations.second.to_s)
  end

  class NameSafePORORule < Ruling::Rule
    synopsis 'İsimlerde güvensiz karakterler olmamalı'
    subject :name

    VIOLATION_PATTERN = {
      'Türkçe karakter içeriyor' => /[şğüöçıĞÜŞÖÇİ]/,
      'Boşluk içeriyor' => /\s/
    }.freeze

    def self.setup(context)
      context.seen = {}
    end

    rule 'no Turkish character' do
      spot_if 'Türkçe karakter içeriyor'
    end

    rule 'no space character' do
      spot_if 'Boşluk içeriyor'
    end

    rule 'must be unique' do |context|
      spot if (seen = context.seen)[name]
      seen[name] = true
    end

    protected

    def spot_if(message)
      spot "#{message}: #{name}" if name =~ VIOLATION_PATTERN[message]
    end
  end

  test 'can use a rule class as a PORO' do
    names = %w[
      recai
      serhat
      hüseyin
      irfan
      recai
    ]

    names << 'emre can'

    checker = Ruling::Checker.new names
    violations = checker.check NameSafePORORule

    assert_equal 3, violations.size
    assert_match(/Türkçe karakter içeriyor: hüseyin/, violations.first.to_s)
    assert_match(/must be unique: recai/, violations.second.to_s)
    assert_match(/Boşluk içeriyor: emre can/, violations.third.to_s)
  end
end
