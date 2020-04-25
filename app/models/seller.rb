class Seller < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, uniqueness: { scope: :first_name }

  has_one_attached :profile_picture
  has_many :products
end
