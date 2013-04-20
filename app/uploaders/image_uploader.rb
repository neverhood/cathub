require 'carrierwave/processing/mime_types'

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  #

  # Uniquely randomize the filename
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg pjpeg gif png bmp tiff)
  end

  def create_animation_thumbnail
    image_format = `identify -format "%m" #{self.path}`.split.first

    if image_format.present? and image_format =~ /gif/i
      self.model.gif = true

      manipulate! { |img, index| index.to_i.zero?? img : nil }
    end
  end

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermarks/watermark.png").first
      img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
    end
  end


  process :set_content_type
  #process resize_to_limit: [ 800, 600 ], unless: :processing_required?

  version :large, unless: :processing_required? do
    process resize_to_limit: [ 800, 600 ]
  end

  version :thumb do
    process :create_animation_thumbnail
    process resize_to_limit: [ 200, 200 ]
    process convert: 'png'
  end

  after :store, :unlink_original

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  #

  def processing_required?
    return model.processing_required unless model.processing_required.nil?

    model.processing_required = begin
                                  image_format = `identify -format "%m" #{self.path}`.split.first

                                  not (image_format.present? and image_format =~ /gif/i)
                                end
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def unlink_original file
    File.delete self.file.file if version_name.blank?
  end

end
