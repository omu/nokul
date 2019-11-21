# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def to_year(datetime)
    datetime&.strftime('%Y')
  end
end
