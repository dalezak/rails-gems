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

require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
