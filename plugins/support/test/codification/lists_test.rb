# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class ListsTest < ActiveSupport::TestCase
        test 'base class works' do
          assert_equal %w[foo bar], Lists::List.new(%w[foo bar])
        end

        class Foo < Lists::List
          protected

          def generate
            source.first
          end
        end

        test 'inheritance works' do
          assert_equal 'foo', Foo.new(%w[foo bar])
        end

        test 'can work without any source' do
          assert_equal [], Lists::List.new
        end

        class Bar < Lists::List
          protected

          def generate
            %w[foo bar]
          end
        end

        test 'can work with an internal source' do
          assert_equal %w[foo bar], Bar.new
        end

        class Baz < Lists::List
          protected

          def sanitize(source)
            raise(Error, 'invalid length') unless source.size == 2

            source
          end

          def generate
            %w[foo bar]
          end
        end

        test 'can sanitize' do
          assert_raise(TypeError) { Lists::List.new 'foo' }
          assert_raise(Error) { Baz.new %w[foo] }
        end

        test 'last item should always be the source itself' do
          source = %w[gabriel garcia marquez]
          %i[abbreviated non_abbreviated].each do |alternative|
            assert_equal source, Lists::UserNames.new(source, alternative: alternative).last
          end
        end

        test 'abbreviated names work' do
          assert_equal [
            %w[g g marquez],
            %w[g garcia m],
            %w[gabriel g m],
            %w[g garcia marquez],
            %w[gabriel g marquez],
            %w[gabriel garcia m],
            %w[gabriel garcia marquez]
          ], Lists::UserNames.new(%w[gabriel garcia marquez], alternative: :abbreviated)
        end

        test 'non_abbreviated names work' do
          assert_equal [
            %w[gabriel marquez],
            %w[garcia marquez],
            %w[gabriel garcia marquez]
          ], Lists::UserNames.new(%w[gabriel garcia marquez], alternative: :non_abbreviated)
        end
      end
    end
  end
end
