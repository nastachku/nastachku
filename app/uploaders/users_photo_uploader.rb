# encoding: utf-8

class UsersPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_limit: [256, 256]

  def extension_white_list
   %w(jpg jpeg gif png)
  end

end