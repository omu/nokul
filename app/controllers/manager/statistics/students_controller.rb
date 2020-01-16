# frozen_string_literal: true

module Manager
  module Statistics
    class StudentsController < ApplicationController
      layout false

      def index; end

      def cities
        @series = Xokul::Ubs::Statistic::Student.by_cities.map do |item|
          {
            name:   item[:city].capitalize_turkish,
            male:   item[:male],
            female: item[:female],
            value:  item[:total]
          }
        end.to_json
      end

      def double_major_and_minor
        data    = Xokul::Ubs::Statistic::Student.double_major_and_minor
        @series = data.reject { |item| item[:category] == 'other' }.map do |item|
          {
            name: case item[:category]
                  when 'minor' then 'Yandal'
                  when 'double major' then 'Çift Anadal'
                  end,
            y:    item[:number_of_students]
          }
        end.to_json
      end

      def genders
        @series = Xokul::Ubs::Statistic::Student.by_genders.map do |item|
          {
            name:  item[:gender],
            color: (
              case item[:gender]
              when 'Erkek' then '#96d1c7'
              when 'Kadın' then '#fc7978'
              else              '#ffafb0'
              end
            ),
            y:     item[:number_of_students]
          }
        end.to_json
      end

      def genders_and_degrees
        data        = Xokul::Ubs::Statistic::Student.by_genders_and_degree
        @categories = data.map { |item| item[:degree] }.uniq
        @genders    = data.map { |item| item[:gender] }.uniq.sort
        @series     = @genders.map do |gender, _hash|
          {
            name:  gender,
            color: (
              case gender
              when 'Erkek' then '#96d1c7'
              when 'Kadın' then '#fc7978'
              else              '#ffafb0'
              end
            ),
            data:  @categories.map do |category|
              row = data.find { |item| item[:degree] == category && item[:gender] == gender } || {}
              row[:number_of_students]
            end
          }
        end.to_json
      end

      def non_graduates
        data        = Xokul::Ubs::Statistic::Student.non_graduates
        @categories = data.map { |item| item[:educational_level] }.uniq
        @statuses   = data.map { |item| item[:status] }.uniq.sort
        @series     = @statuses.map do |status, _hash|
          {
            name:  status,
            color: (
              case status
              when 'Uzatan' then '#8E2C3E'
              when 'Normal' then '#B27D32'
              end
            ),
            data:  @categories.map do |category|
              row = data.find { |item| item[:educational_level] == category && item[:status] == status } || {}
              row[:number_of_students]
            end
          }
        end.to_json
      end
    end
  end
end
