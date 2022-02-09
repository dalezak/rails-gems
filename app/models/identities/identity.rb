# == Schema Information
#
# Table name: identities
#
#  id            :uuid             not null, primary key
#  user_id       :uuid             not null
#  provider      :string
#  uid           :string
#  token         :string
#  refresh_token :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_identities_on_provider       (provider)
#  index_identities_on_refresh_token  (refresh_token)
#  index_identities_on_token          (token)
#  index_identities_on_uid            (uid)
#  index_identities_on_user_id        (user_id)
#

class Identity < ApplicationRecord

  belongs_to :user, counter_cache: true

end
