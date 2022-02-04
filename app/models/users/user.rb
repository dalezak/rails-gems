class User < ApplicationRecord
  
  include ::Typeable
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :validatable

  # store_attribute :details, :extra, :string
  
  has_many :identities, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :gems, class_name: "Gemm", foreign_key: "gem_id", through: :likes, dependent: :destroy
  
  scope :for_search, ->(query) { where(email: query).or(where("name ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query))).or(where(username: query.downcase)) if query.present? }

  def self.from_omniauth(auth)
    if auth.present? && auth.provider.present? && auth.uid.present?
      identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      if auth.credentials.present?
        identity.token = auth.credentials.token
        identity.refresh_token = auth.credentials.refresh_token
      end
      identity.save!
      if identity.user.present?
        identity.user
      else
        password = Devise.friendly_token
        User.create!(
          identity: identity,
          email: auth.info.email,
          password: password,
          password_confirmation: password)
      end
    end
  end
  
end
