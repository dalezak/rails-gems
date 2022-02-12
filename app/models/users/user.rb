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

class User < ApplicationRecord

  include ::Typeable
  include ::Slugable
  include ::Iconable
  include ::Imageable
  include ImageUploader::Attachment(:image)

  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :validatable

  store_attribute :details, :location, :string
  store_attribute :details, :homepage_uri, :string
  store_attribute :details, :github_uri, :string
  store_attribute :details, :twitter_uri, :string
  store_attribute :details, :gem_list, :json, default: []

  has_many :identities, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :gems, class_name: "Gemm", foreign_key: "gem_id", through: :likes, dependent: :destroy

  scope :for_gem, ->(gem) { joins(:likes).where(likes: { gem_id: gem.id }) if gem.present? }
  scope :for_search, ->(query) { where(email: query).or(where("name ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query))).or(where(username: query.downcase)) if query.present? }

  validates :name, presence: true
  validates :email, presence: true

  def self.icon
    "fa-user"
  end

  def admin?
    self.is_a?(Admin)
  end

  def guest?
    self.is_a?(Guest)
  end

  def self.from_omniauth(auth)
    if auth.present? && auth.provider.present? && auth.uid.present?
      identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      if auth.credentials.present?
        identity.token = auth.credentials.token
        identity.refresh_token = auth.credentials.refresh_token
      end
      if identity.user.nil?
        user = User.first_or_initialize(email: auth.info.email)
        user.name = auth.info.name
        user.password = Devise.friendly_token if user.new_record?
        user.save
        identity.user = user
      end
      identity.save!
      identity.user
    end
  end

end
