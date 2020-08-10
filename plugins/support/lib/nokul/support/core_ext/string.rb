# frozen_string_literal: true

class String
  TURKISH_CHARS = {
    'ı' => 'i',
    'ğ' => 'g',
    'ü' => 'u',
    'ş' => 's',
    'ö' => 'o',
    'ç' => 'c',
    'İ' => 'I',
    'Ğ' => 'G',
    'Ü' => 'U',
    'Ş' => 'S',
    'Ö' => 'O',
    'Ç' => 'C'
  }.freeze

  # Regex stolen from https://stackoverflow.com/a/6331667
  RE_PARANTHESIZED = /
    (?<re>
      \(
        (?:
          (?> [^()]+ )
          |
          \g<re>
        )*
      \)
    )
    /x.freeze

  def asciified
    chars.to_a.map { |char| (ascii = TURKISH_CHARS[char]) ? ascii : char }.join
  end

  def affixed(**options)
    [self].join_affixed(**options)
  end

  def abbreviation
    split.map(&:first).join.upcase(:turkic)
  end

  def capitalize_turkish
    downcase(:turkic).split.map do |word|
      if word.inside_abbreviations? :tr
        word.upcase(:turkic)
      elsif word.inside_conjunctions? :tr
        word
      else
        word.capitalize(:turkic)
      end
    end.join(' ')
  end

  def capitalize_turkish_with_parenthesized
    capitalize_turkish.gsub RE_PARANTHESIZED do |match|
      "(#{match[1..-2].capitalize_turkish})"
    end
  end

  module Matchable
    require 'yaml'

    class Matcher
      attr_reader :data

      def initialize
        @data = {}
      end

      def run(languages:, category:, word:)
        (languages.empty? ? %w[en tr] : languages.uniq).each do |language|
          return true if match(language: language, category: category, word: word)
        end

        false
      end

      def match(language:, category:, word:)
        words(language, category).include? word
      end

      private

      # We should be lazy on all operations involving data access (hence the
      # heavy use of or-equals operators).

      def words(language, category)
        language_data_for(language)[category.to_s] ||= Set.new []
      end

      def language_data_for(language)
        data[language = language.to_s] ||= begin
          (file = language_file_for(language)) ? YAML.load_file(file) : {}
        end
      end

      def language_file_for(language)
        @lookup ||= Hash[*
          Dir[File.join File.expand_path('../data', __dir__), '*.yml'].map do |file|
            name = File.basename(file, '.yml')
            [name, file]
          end.flatten
        ]
        @lookup[language]
      end
    end

    mattr_accessor :matcher, default: Matcher.new

    # Create inside_CATEGORY? wrappers
    %w[
      abbreviations
      conjunctions
      offensives
      reserved
    ].each do |category|
      define_method "inside_#{category}?" do |*languages|
        matcher.run(languages: languages, category: category, word: self)
      end
    end
  end

  include Matchable # rubocop:disable Layout/ClassStructure
end
