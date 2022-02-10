module Iconable
  extend ActiveSupport::Concern

  included do
    def self.icon
      "question-circle"
    end
  end

  delegate :icon, to: :class

end  