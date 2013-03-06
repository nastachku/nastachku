# encoding: utf-8

class EventPresentationUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
