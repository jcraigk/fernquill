class User < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.from_omniauth(auth)
    identity = Identity.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user = identity.user || find_or_initialize_by(email: auth.info.email)
    user.update!(name: auth.info.name, avatar_url: auth.info.image)
    identity.update!(user:)
    user
  end
end
