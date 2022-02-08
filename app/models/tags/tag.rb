class Tag < ApplicationRecord

  include ::Slugable

  has_many :taggings, dependent: :destroy
  has_many :gems, class_name: "Gemm", foreign_key: "gem_id", through: :taggings

  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query)) if query.present? }

  validates :name, uniqueness: true
  
  def self.all_cached
    Rails.cache.fetch(["tags:all", Tag.maximum(:updated_at)]) do
      Tag.order(name: :asc).all.to_a
    end
  end
  
end
