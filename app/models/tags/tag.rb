# == Schema Information
#
# Table name: tags
#
#  id             :uuid             not null, primary key
#  slug           :string
#  name           :string
#  synonyms       :jsonb            default("{}"), is an Array
#  taggings_count :integer          default("0")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name)
#  index_tags_on_slug  (slug)
#

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

  def synonym?(sentence)
    self.synonyms.each do |synonym|
      if sentence.gsub(",", " ").gsub(".", " ").downcase.split.include?(synonym)
        return true
      end
    end
    false
  end

end
