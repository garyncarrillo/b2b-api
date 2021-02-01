class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_uuid
  after_create :create_nick_name

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

  def create_nick_name
    len = 6
    self.nick_name = self.first_name[0..1] + self.last_name[0] + SecureRandom.random_number(10**len).to_s.rjust(len, '0')
    self.save
  end
end
