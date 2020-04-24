class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :initial_amount, presence: true
  validates :bid_amount, presence: true
  validates :images, presence: true

  belongs_to :auction, optional: true
  belongs_to :article
  belongs_to :seller
  has_many_attached :images
  has_many :favourites, as: :favouritable

  enum currency: [ :cop, :dollar ]
  enum unit_of_measure: [ :u, :kg, :lt ]
end
