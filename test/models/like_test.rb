# == Schema Information
#
# Table name: likes
#
#  id         :uuid             not null, primary key
#  gem_id     :uuid             not null
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_likes_on_gem_id   (gem_id)
#  index_likes_on_user_id  (user_id)
#

require "test_helper"

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
