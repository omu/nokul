# frozen_string_literal: true

module ToastrHelper
  def toastr_flash_class(type)
    # See https://github.com/plataformatec/devise/issues/1777 for type check in toastr partial
    {
      'alert' => 'toastr.error',
      'notice' => 'toastr.success'
    }.fetch(type, 'toastr.info')
  end
end
