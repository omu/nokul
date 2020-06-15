# frozen_string_literal: true

module V1
  class UndergraduateRegulation < Extensions::Regulation::Base
    identifier      :undergraduate
    number          31_103
    effective_date '23/05/2020'
    repealed_at    '15/06/2020'
    scope          :education
  end
end
