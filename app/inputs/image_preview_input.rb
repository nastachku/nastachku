class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input
    style = options.delete(:preview_style)
    out = super
    if object.persisted? && object.send("#{attribute_name}?")
      #out << template.content_tag(:div, template.content_tag(:span, "Current photo:"))
      out << template.content_tag(:div, template.image_tag(object.send(:"#{attribute_name}_url", style)) )
    end
    out
  end
end