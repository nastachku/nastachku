class ColorPickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    super()
  end

  def input_html_classes
    super.push('color-picker')
  end
end
