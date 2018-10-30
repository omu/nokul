# frozen_string_literal: true

module Xokul
  module Yoksis
    module Staff
      module_function

      def academicians(id_number:)
        Connection.request(
          '/yoksis/staff/academicians', params: { id_number: id_number }
        )
      end

      def nationalities
        Connection.request '/yoksis/staff/nationalities'
      end

      def pages(page:)
        Connection.request '/yoksis/staff/pages', params: { page: page }
      end

      def total_pages
        Connection.request('/yoksis/staff/total_pages')[:total_pages]
      end
    end
  end
end
