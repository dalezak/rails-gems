class Like < ApplicationRecord

  belongs_to :user, inverse_of: :likes, class_name: "User", counter_cache: "likes_count", touch: true
  belongs_to :gem, inverse_of: :likes, class_name: "Gemm", counter_cache: "likes_count", touch: true

  scope :for_user, ->(user) { where(user_id: user.id) if user.present? }
  scope :for_users, ->(users) { where(user_id: users.pluck(:id)) if users.present? }

  scope :for_gem, ->(gem) { where(gem_id: gem.id) if gem.present? }
  scope :for_gems, ->(gems) { where(gem_id: gems.pluck(:id)) if gems.present? }

end
