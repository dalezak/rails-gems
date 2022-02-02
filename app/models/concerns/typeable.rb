module Typeable
  extend ActiveSupport::Concern

  class_methods do
    def type_name
      name.underscore.humanize.titleize
    end
  end
  
  def type_name
    self.type.underscore.humanize.titleize
  end

end  