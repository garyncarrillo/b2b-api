class Product < ApplicationRecord
  enum currency: [:cop, :dollar]
  enum unit_of_measure: [:u, :kg, :lt]

  validates :name, presence: true
  validates :description, presence: true
  validates :initial_amount, presence: true
  validates :bid_amount, presence: true
  # validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], limit: { min: 1 }
  validates :currency, presence: true, inclusion: { in: Product.currencies.keys }
  validates :quantity, presence: true
  validates :unit_of_measure, presence: true, inclusion: { in: Product.unit_of_measures.keys }
  validates :place_of_delivery, presence: true

  belongs_to :auction, optional: true
  belongs_to :article
  belongs_to :seller
  has_many_attached :images
  has_many :favourites, as: :favouritable
end
