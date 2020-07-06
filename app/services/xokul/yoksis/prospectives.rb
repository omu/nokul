# frozen_string_literal: true

module Xokul
  module Yoksis
    module Prospectives
      module_function

      def all(type, year, page: 1, per_page: 100)
        path = path_with_page_params '/yoksis/prospectives/students', page, per_page
        Connection.request path, params: { prospective: { type: type, year: year } }
      end

      def online_registered_students(type, year, page: 1, per_page: 100)
        path = path_with_page_params '/yoksis/prospectives/students', page, per_page
        Connection.request path, params: { prospective: { type: type, year: year, registration_type: 'online' } }
      end

      def manual_registered_students(type, year, page: 1, per_page: 100)
        path = path_with_page_params '/yoksis/prospectives/students', page, per_page
        Connection.request path, params: { prospective: { type: type, year: year, registration_type: 'manual' } }
      end

      def student(type, year, id_number)
        Connection.request(
          '/yoksis/prospectives/students', params: { prospective: { type: type, year: year, id_number: id_number } }
        )
      end

      def photo(id_number)
        Connection.request(
          '/yoksis/prospectives/students/photo', params: { prospective: { id_number: id_number } }
        )&.fetch(:image, nil)
      end

      def path_with_page_params(path, page, per_page)
        "#{path}?page=#{page}&per_page=#{per_page}"
      end

      private_class_method :path_with_page_params
    end
  end
end
