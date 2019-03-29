# frozen_string_literal: true

require 'singleton'

require_relative 'coder/pool'
require_relative 'coder/reservation'

module Nokul
  module Tenant
    module Units
      class Coder
        class Memory < Support::Codification::SimpleMemory
          include Singleton
        end

        def self.code(units, config)
          new(config).code(units)
        end

        attr_reader :pools, :reservations, :memory

        def initialize(config)
          @memory       = Memory.instance
          @pools        = Pools.create config.pools
          @reservations = Reservations.create config.reservations
        end

        def code(units)
          active_units = units.select(&:live?)

          fulfill_reservations(active_units)
          code_by_selected_pool(active_units)
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
            if (code = unit.code).present?
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
end
