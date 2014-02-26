# encoding: utf-8

class SectionIconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/uploads/sections_icons/#{mounted_as}/#{model.id}"
  end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

  def extension_white_list
   %w(jpg jpeg gif png)
  end
end
