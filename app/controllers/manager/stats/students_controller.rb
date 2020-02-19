# frozen_string_literal: true

module Manager
  module Stats
    class StudentsController < ApplicationController
      layout false
      before_action do
        authorize(current_user, policy_class: Manager::Stats::StudentPolicy)
      end

      def index; end

      def cities
        @series = Xokul::Ubs::Statistic::Student.by_cities(
          schema: {
            city:  :name,
            total: :value
          }
        ).each { |item| item[:name] = item[:name].capitalize_turkish }.to_json
      end

      def double_major_and_minor
        @series = Xokul::Ubs::Statistic::Student.double_major_and_minor(
          schema: {
            category:           :name,
            number_of_students: :y
          }
        ).to_json
      end

      def genders
        @series = Xokul::Ubs::Statistic::Student.by_genders(
          schema: {
            gender:             :name,
            number_of_students: :y
          }
        ).to_json
      end

      def genders_and_degrees
        data     = Xokul::Ubs::Statistic::Student.by_genders_and_degree
        @degrees = data.map { |item| item[:degree] }.uniq
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
        data     = Xokul::Ubs::Statistic::Student.non_graduates
        @degrees = data.map { |item| item[:degree] }.uniq
        @series  = data.group_by { |item| item[:status] }.map do |status, values|
          {
            name: status,
            data: @degrees.map do |degree|
              values.find { |v| v[:degree] == degree }&.fetch(:number_of_students, 0)
            end
          }
        end.to_json
      end
    end
  end
end
