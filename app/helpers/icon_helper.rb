# frozen_string_literal: true

module IconHelper
  def icon_for_check(status)
    if status
      tag.span class: 'text-success' do
        fa_icon('check-circle-o')
      end
    else
      tag.span class: 'text-danger' do
        fa_icon('times-circle-o')
      end
    end
  end
end
