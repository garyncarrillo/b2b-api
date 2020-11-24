class CustomerUser < User
  has_many :customer_auctions, foreign_key: :user_id, dependent: :destroy
  has_many :on_site_customer_auctions, -> { where({ ubication: CustomerAuction::ON_SITE }) }, class_name: 'CustomerAuction', foreign_key: :user_id
  has_many :auctions, through: :customer_auctions

  def active_for_authentication?
      super && active
  end
end
