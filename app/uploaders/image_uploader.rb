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
      small:  magick.resize_to_limit!(33, 33),
      medium: magick.resize_to_limit!(72, 72),
      large: magick.resize_to_limit!(100, 100)
    }
  end

end
