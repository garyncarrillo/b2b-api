class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
end
