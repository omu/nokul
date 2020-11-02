# frozen_string_literal: true

module Manager
  module Stats
    class StudentsController < ApplicationController
      layout false
      before_action do
        authorize(current_user, policy_class: Manager::Stats::StudentPolicy)
      end
      rescue_from Nokul::Support::RestClient::HTTPError, with: -> {
        render status: :internal_server_error
      }

      def index; end

      def cities
        @series = Xokul::UBS::Statistic::Student.by_cities(
          schema: {
            city:  :name,
            total: :value
          }
        ).each { |item| item[:name] = item[:name].capitalize_turkish }.to_json
      end

      def double_major_and_minor
        @series = Xokul::UBS::Statistic::Student.double_major_and_minor(
          schema: {
            category:           :name,
            number_of_students: :y
          }
        ).to_json
      end

      def genders
        @series = Xokul::UBS::Statistic::Student.by_genders(
          schema: {
            gender:             :name,
            number_of_students: :y
          }
        ).to_json
      end

      def genders_and_degrees
        data     = Xokul::UBS::Statistic::Student.by_genders_and_degree
        @degrees = data.pluck(:degree).uniq!
        @series  = data.group_by { |item| item[:gender] }.map do |gender, values|
          {
            name: gender,
            data: @degrees.map do |degree|
              values.find { |v| v[:degree] == degree }&.fetch(:number_of_students, 0)
            end
          }
        end.to_json
      end

      def non_graduates
        data     = Xokul::UBS::Statistic::Student.non_graduates
        @degrees = data.pluck(:degree).uniq!
        @series  = data.group_by { |item| item[:status] }.map do |status, values|
          {
            name: status,
            data: @degrees.map do |degree|
              values.find { |v| v[:degree] == degree }&.fetch(:number_of_students, 0)
            end
          }
        end.to_json
      end

      def units
        data = Xokul::UBS::Statistic::Student.by_nested_units
        @series = data.values.map do |value|
          {
            name: value[:name], y: value[:total], number_of_students: value[:number_of_students], drilldown: value[:name]
          }
        end.to_json

        @details = data.values.map do |value|
          {
            name: value[:name],
            id:   value[:name],
            data: value[:children].values.map do |child|
              { name: child[:name], y: child[:total], number_of_students: child[:number_of_students] }
            end
          }
        end.to_json
      end
    end
  end
end
