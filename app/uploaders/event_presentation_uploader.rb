# encoding: utf-8

class EventPresentationUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "system/uploads/#{model.model_name.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
   %w(ppt pptx pdf odp)
  end
end
