# frozen_string_literal: true

require 'singleton'

require_relative 'coder/pool'
require_relative 'coder/reservation'

module Tenant
  class Unit
    class Coder
      class Memory < Coding::SimpleMemory
        include Singleton
      end

      attr_reader :pools, :reservations, :memory

      def initialize(config_file)
        config = YAML.load_file(config_file) || {}

        @memory       = Memory.instance
        @pools        = Pools.from_hashes config['pools']
        @reservations = Reservations.from_hashes config['reservations']
      end

      def code(units)
        fulfill_reservations(units)
        code_by_selected_pool(units)
      end

      protected

      def fulfill_reservations(units)
        units.each do |unit|
          reservations.each do |reservation|
            next unless unit.send(reservation.key) == reservation.value

            memory.remember unit.code = reservation.reservation.to_s
          end
        end
      end

      def code_by_selected_pool(units)
        units.each do |unit|
          unless (code = unit.code).blank?
            memory.remember code
            next
          end
          selected_pool = pools.reject(&:reserved).max_by do |pool|
            pool.score_of(unit)
          end

          unit.code = selected_pool.code
        end
      end
    end
  end
end
