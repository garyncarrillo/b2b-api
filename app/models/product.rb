class Product < ApplicationRecord
  enum currency: [:cop, :dollar]
  enum unit_of_measure: [:u, :kg, :lt]

  validates :name, presence: true
  validates :description, presence: true
  validates :initial_amount, presence: true
  validates :bid_amount, presence: true
  validates :attached_1_file, content_type: ['application/pdf']
  validates :attached_2_file, content_type: ['application/pdf']
  validates :currency, presence: true, inclusion: { in: Product.currencies.keys }
  validates :quantity, presence: true
  validates :unit_of_measure, presence: true, inclusion: { in: Product.unit_of_measures.keys }
  validates :place_of_delivery, presence: true

  has_one_attached :attached_1_file
  has_one_attached :attached_2_file
  has_many_attached :images

  belongs_to :auction, optional: true
  belongs_to :article
  belongs_to :seller
  has_many :favourites, as: :favouritable
end
