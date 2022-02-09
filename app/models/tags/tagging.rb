class Tagging < ApplicationRecord

  belongs_to :tag, counter_cache: :taggings_count
  belongs_to :gem, class_name: "Gemm", counter_cache: :tags_count

  validates :gem_id, uniqueness: { scope: :tag_id }

end
