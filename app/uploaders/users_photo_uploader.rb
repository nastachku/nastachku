# encoding: utf-8

class UsersPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/uploads/users_photos/#{mounted_as}/#{model.id}"
  end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

  process resize_to_fill: [455, 450]

  def extension_white_list
   %w(jpg jpeg png)
  end

end
