# frozen_string_literal: true

module Xokul
  module Meksis
    module_function

    def parent_place_types
      Connection.request('/meksis/main_functions')
    end

    def children_place_types
      Connection.request('/meksis/sub_functions')
    end

    def buildings
      Connection.request('/meksis/buildings')
    end

    def classrooms(building_id)
      Connection.request('/meksis/classrooms', params: { building_id: building_id })
    end

    def syllabuses_by_classroom(classroom_id, year, term)
      Connection.request(
        '/meksis/classroom_syllabuses',
        params: { classroom_id: classroom_id, year: year, term: term }
      )
    end

    def syllabuses_by_unit(unit_id, year, term)
      Connection.request(
        '/meksis/unit_syllabuses',
        params: { unit_id: unit_id, year: year, term: term }
      )
    end
  end
end
