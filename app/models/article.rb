class Article < ApplicationRecord
  validates :name, presence: true
  validates :category_id, presence: true

  belongs_to :category
  has_many :favourites, as: :favouritable
end
