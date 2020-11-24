class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_uuid

  devise :invitable, :database_authenticatable, :registerable,
         :invitable,
         # :validatable,
         :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true

  has_many :favourites
  has_many :bids

  def create_uuid
    self.uuid = SecureRandom.uuid
    self.save
  end
end
