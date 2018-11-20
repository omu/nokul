# frozen_string_literal: true

module ToastrHelper
  def toastr_flash_class(type)
    {
      'alert' => 'toastr.error',
      'notice' => 'toastr.success'
    }.fetch(type, 'toastr.info')
  end
end
