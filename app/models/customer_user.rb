class CustomerUser < User
  has_many :customer_auctions, foreign_key: :user_id
  has_many :auctions, through: :customer_auctions

  def active_for_authentication?
      super && active
  end
end
