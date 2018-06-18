# frozen_string_literal: true

module ToastrHelper
  def toastr_flash_class(type)
    case type
    when 'alert'
      'toastr.error'
    when 'notice'
      'toastr.success'
    else
      'toastr.info'
    end
  end
end
