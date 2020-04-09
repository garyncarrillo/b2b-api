class Auction < ApplicationRecord
  validates :name, presence: true
  validates :start_at, presence: true

  has_many :favourites, as: :favouritable
  has_many :products
end
