# encoding: utf-8

class UsersPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/uploads/users_photos/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [256, 256]

  def extension_white_list
   %w(jpg jpeg gif png)
  end

end
