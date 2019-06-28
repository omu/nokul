# frozen_string_literal: true

module ComponentHelper
  STATUSES = {
    success:      'success',
    failed:       'danger',
    pending:      'warning',
    synchronized: 'success'
  }.freeze

  def to_list_group(items, **options)
    return items unless items.is_a?(Array)

    tag.ul(class: options.fetch(:ul_class, 'list-group')) do
      safe_join(
        items.map { |item| tag.li(item, class: options.fetch(:li_class, 'list-group-item')) }
      )
    end
  end

  def klass_for_status(status)
    return 'secondary' if status.nil?

    STATUSES.fetch(status.to_sym, 'secondary')
  end
end
