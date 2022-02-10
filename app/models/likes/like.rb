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

class Like < ApplicationRecord

  after_create :update_user
  after_destroy :update_user

  belongs_to :user, inverse_of: :likes, class_name: "User", counter_cache: "likes_count", touch: true
  belongs_to :gem, inverse_of: :likes, class_name: "Gemm", counter_cache: "likes_count", touch: true

  scope :for_user, ->(user) { where(user_id: user.id) if user.present? }
  scope :for_users, ->(users) { where(user_id: users.pluck(:id)) if users.present? }

  scope :for_gem, ->(gem) { where(gem_id: gem.id) if gem.present? }
  scope :for_gems, ->(gems) { where(gem_id: gems.pluck(:id)) if gems.present? }

  def update_user
    self.user.update(gem_list: self.user.gems.map{|gem| gem.name})
  end

end
