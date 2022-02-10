# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  type                   :string           default("User")
#  slug                   :string
#  name                   :string
#  title                  :string
#  description            :text
#  image_data             :jsonb
#  details                :jsonb            default("{}")
#  likes_count            :integer          default("0")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  identities_count       :integer          default("0")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug)
#  index_users_on_type                  (type)
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
