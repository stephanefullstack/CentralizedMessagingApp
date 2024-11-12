class User < ApplicationRecord
  # Supprimez `has_secure_password` ici
  # has_secure_password

  # Devise configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist, skip_session_storage: [:http_auth]
end
