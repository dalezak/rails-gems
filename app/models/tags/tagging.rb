# == Schema Information
#
# Table name: taggings
#
#  id         :uuid             not null, primary key
#  gem_id     :uuid             not null
#  tag_id     :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_taggings_on_gem_id             (gem_id)
#  index_taggings_on_gem_id_and_tag_id  (gem_id,tag_id) UNIQUE
#  index_taggings_on_tag_id             (tag_id)
#

class Tagging < ApplicationRecord

  belongs_to :tag, counter_cache: :taggings_count
  belongs_to :gem, class_name: "Gemm", counter_cache: :tags_count

  validates :gem_id, uniqueness: { scope: :tag_id }

end
