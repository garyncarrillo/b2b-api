class CustomerUser < User
  has_many :customer_auctions, foreign_key: :user_id
  has_many :auctions, through: :customer_auctions
end
