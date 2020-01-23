# frozen_string_literal: true

module Detsis
  class SdpCodesController < ApplicationController
    include SearchableModule

    def index
      sdp_codes = SdpCode.order(:main).dynamic_search(search_params(SdpCode))
      @pagy, @paginated = pagy(sdp_codes)
    end
  end
end
