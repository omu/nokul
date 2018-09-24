# frozen_string_literal: true

module YoksisReferences
  class StudentPunishmentTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_punishment_type).permit(:name, :code)
    end
  end
end
