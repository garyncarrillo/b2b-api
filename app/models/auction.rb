class Auction < ApplicationRecord
  validates :name, presence: true
  validates :start_at, presence: true
  validates :description, presence: true
  validates :contact_phone, presence: true
  validates :auction_type, presence: true, inclusion: { in: %w(on-site online hybrid) }
  validates :terms_and_conditions, presence: true
  validates :terms_and_conditions, presence: true

  has_many :favourites, as: :favouritable
  has_many :products

  aasm column: :state do
    state :new, initial: true
    state :scheduled
    state :started
    state :finished
  end
end
