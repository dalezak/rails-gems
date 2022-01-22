class User < ApplicationRecord
  
  has_many :identities, dependent: :destroy
  
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
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable
end
