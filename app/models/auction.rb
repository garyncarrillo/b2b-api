class Auction < ApplicationRecord
  include AASM

  validates :name, presence: true
  validates :start_at, presence: true
  validates :description, presence: true
  validates :contact_phone, presence: true
  validates :auction_type, presence: true
  validates :terms_and_conditions, presence: true
  validates :terms_and_conditions, presence: true

  has_many :customer_auctions, dependent: :destroy
  has_many :customers, through: :customer_auctions, foreign_key: :user_id
  has_many :favourites, as: :favouritable, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :on_site_users, dependent: :destroy

  enum auction_type: [ :'on-site', :'online', :hybrid ]

  aasm column: :state do
    state :new, initial: true
    state :scheduled
    state :started
    state :finished
  end
end
