class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, uniqueness: true
end