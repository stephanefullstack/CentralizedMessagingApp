class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  # Facultatif, pour s'assurer que le champ `jti` est unique
  validates :jti, presence: true, uniqueness: true
end
