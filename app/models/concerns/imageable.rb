module Imageable
  extend ActiveSupport::Concern

  included do
    before_save :image_resize
  end

  def image_resize
    self.image_derivatives! if self.image_changed?
  end

end
