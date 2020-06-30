# frozen_string_literal: true

class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.tag.div(class: 'input-group input-datetime flatpickr') do
      template.concat @builder.text_field(attribute_name, merge_wrapper_options(input_html_options, wrapper_options))
      template.concat @builder.full_error(attribute_name, class: 'invalid-feedback d-block')
    end
  end

  def input_html_options
    super.merge(
      class:    'datetimepicker',
      readonly: true
    )
  end
end
