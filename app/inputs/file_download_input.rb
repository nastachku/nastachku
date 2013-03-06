class FileDownloadInput < SimpleForm::Inputs::FileInput
  def input
    style = options.delete(:preview_style)
    out = super
    if object.persisted? 
      out << template.content_tag(:div) do
        template.link_to( object.send("#{attribute_name}_identifier"), object.send("#{attribute_name}_url"))
      end
    end
    out
  end
end