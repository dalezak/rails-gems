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

require "test_helper"

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
