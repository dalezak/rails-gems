module Slugable
  extend ActiveSupport::Concern

  included do
    before_validation :set_slug

    def self.with_slug(id_or_slug)
      where(id: id_or_slug).or(where(slug: id_or_slug.to_s))
    end

    def self.find(id_or_slug)
      where(id: id_or_slug).or(where(slug: id_or_slug.to_s)).first
    end

    def self.find!(id_or_slug)
      where(id: id_or_slug).or(where(slug: id_or_slug.to_s)).first!
    end
  end

  def to_param
    self.slug.presence || self.id
  end

  def set_slug
    if self.slug.blank?
      prefix = (self.try(:name) || self.try(:title) || SecureRandom.hex).parameterize
      suffix = nil
      while self.class.where(slug: [prefix, suffix].compact.join('-')).count.positive? do
        suffix = suffix.to_i + 1
      end
      self.slug = [prefix, suffix].compact.join('-')
    end
  end

end