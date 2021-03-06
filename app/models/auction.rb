class Auction < ApplicationRecord
  include AASM

  validates :name, presence: true
  validates :start_at, presence: true
  validates :description, presence: true
  validates :contact_phone, presence: true
  validates :auction_type, presence: true
  validates :terms_and_conditions, presence: true
  validates :time_bit, presence: true
  validates :place, presence: true
  validates :terms_and_conditions_file, attached: true, content_type: ['application/pdf']
  validates :products_report_file, attached: true, content_type: ['application/pdf']

  has_many :customer_auctions, dependent: :destroy
  has_many :customers, through: :customer_auctions, foreign_key: :user_id
  has_many :favourites, as: :favouritable, dependent: :destroy
  has_many :products, -> { order(:id => :desc) }, dependent: :destroy
  has_many :on_site_users, dependent: :destroy

  has_one_attached :terms_and_conditions_file
  has_one_attached :products_report_file

  enum auction_type: [ :'on-site', :'online', :hybrid ]

  aasm column: :state do
    state :new, initial: true
    state :scheduled
    state :started
    state :finished

    event :publish do
      transitions from: :new, to: :scheduled
    end

    event :start, after: :started_nofitification do
      transitions from: :scheduled, to: :started
    end

    event :finish, after: :finished_notification do
      transitions from: :started, to: :finished
    end
  end

  def started_nofitification
    self.started = true
    self.save
    AuctionStartingNotificationWorker.perform_async(self.id)
  end

  def finished_notification
    self.started = false
    self.save
  end
end
