# frozen_string_literal: true

module References
  class StudentPunishmentTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_punishment_type).permit(:name, :code)
    end
  end
end
