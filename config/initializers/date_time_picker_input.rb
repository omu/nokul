# frozen_string_literal: true

class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    template.content_tag(:div, class: 'input-group input-datetime') do
      template.concat @builder.text_field(attribute_name, merged_input_options)
    end
  end

  def input_html_options
    options = { class: 'datetimepicker', readonly: true }
    super.merge(options)
  end
end
