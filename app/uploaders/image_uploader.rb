require 'image_processing/mini_magick'
require 'fastimage'

class ImageUploader < Shrine
  plugin :derivatives
  plugin :pretty_location
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :determine_mime_type

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png]
    validate_extension %w[jpg jpeg png]
    validate_max_size 10*1024*1024
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      thumb:  magick.resize_to_limit!(100, 100),
      small:  magick.resize_to_limit!(300, 300),
      medium: magick.resize_to_limit!(600, 600)
      # large:  magick.resize_to_limit!(800, 800)
    }
  end

end
