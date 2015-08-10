inputs = %w[
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end

  Object.const_set(input_type, new_class)
end

class LogoInput < SimpleForm::Inputs::FileInput
  def input
    out = '' # the output string we're going to build
    # check if there's an uploaded file (eg: edit mode or form not saved)
    if object.send("#{attribute_name}?")
      # append preview image to output
      # <%= image_tag @user.avatar.url(:thumb), :class => 'thumbnail', id: 'avatar' %>
      out << template.image_tag(object.send(attribute_name).url(:thumb), :class => 'thumbnail', id: 'logo')
    end
    # append file input. it will work accordingly with your simple_form wrappers
    (out << @builder.file_field(attribute_name, input_html_options)).html_safe
  end
end
