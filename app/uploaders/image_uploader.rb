# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  include Cloudinary::CarrierWave

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [50, 50]
  end

  version :thumbnail do
    process :resize_to_fill => [150, 150]
  end


  version :thumbnail2 do
    # process :resize_to_fill => [150, 150]
    cloudinary_transformation :transformation =>[
        {:width => 150, :height => 150, :crop => :fill}, 
        {  :overlay => "playblack.png", crop: :fill, :width=>0.5, :height=>0.5, :flags=>:relative,
             :gravity => :center }]

  end

  version :twitter do
    # process :resize_to_fill => [150, 150]
    cloudinary_transformation :transformation =>[
        {:width => 600, :height => 600, :crop => :fill}, 
        {  :overlay => "playblack.png", crop: :fill, :width=>0.25, :height=>0.25, :flags=>:relative,
             :gravity => :center }]

  end

   version :embed do
    process :resize_to_fill => [200, 200]
  end

  version :square do
    process :resize_to_fill => [400, 400]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "sample.mp3" if original_filename
  # end

end
