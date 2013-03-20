class FileDownloadInput < SimpleForm::Inputs::FileInput
  def input
    style = options.delete(:preview_style)
    out = super
    if object.persisted? 
      out << template.content_tag(:div) do
        if object.send("#{attribute_name}_url")
          template.link_to( object.send("#{attribute_name}_identifier"), object.send("#{attribute_name}_url"))
        end
      end
    end
    out
  end
end