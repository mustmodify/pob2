class DatedInput < SimpleForm::Inputs::Base
  def input( wrapper_options )
    defaults = {'data-provide' => 'datepicker', :class => ['form-control'], 'data-date-format' => 'yyyy-mm-dd', 'data-date-autoclose' => true}
    merged_input_options = merge_wrapper_options(defaults, wrapper_options)
    merged_input_options = merge_wrapper_options(merged_input_options, input_html_options)

    @builder.text_field(attribute_name, merged_input_options).html_safe
  end
end
