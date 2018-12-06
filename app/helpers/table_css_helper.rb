# frozen_string_literal: true

module TableCssHelper
  def boolean_to_class_for_table(status)
    return 'table-success' if status
    'table-danger'
  end
end
