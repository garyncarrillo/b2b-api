class Auction < ApplicationRecord
  validates :name, presence: true
  validates :start_at, presence: true
end
