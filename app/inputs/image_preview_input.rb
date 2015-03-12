class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    #style = options.delete(:preview_style)
    out = super

    img = if object.persisted? && object.send("#{attribute_name}?")
      object.send(:"#{attribute_name}_url")
    else
      "default-user-image.png"
    end

    out << template.content_tag(
      :div,
      template.image_tag(img, id: "user_photo_preview"),
      class: ["personal__userpic__img"],
    )
    out << template.content_tag(:a, "* Загрузить фотографию", id: "false_photo_input")

    out
  end
end
