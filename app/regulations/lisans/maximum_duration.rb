# frozen_string_literal: true

module Lisans
  class MaximumDuration < Regulation::Article
    name         'Maximum Duration'
    identifier   :lisans_maximum_duration
    number       8
    sub_articles 1
    version      31_103
    register     V1::UndergraduateRegulation

    store do
      {
        2 => 4,
        4 => 7,
        5 => 8,
        6 => 9
      }
    end

    attr_reader :program

    def initialize(program)
      @program = program
    end

    class << self
      def call(program)
        new(program).call
      end
    end

    def call
      store_data.fetch(program.duration)
    end
  end
end
