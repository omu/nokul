# frozen_string_literal: true

module V1
  class UndergraduateRegulation < Extensions::Regulation::Base
    identifier      :undergraduate
    number          30_911
    effective_date '23/05/2020'
    scope          :education
  end
end
