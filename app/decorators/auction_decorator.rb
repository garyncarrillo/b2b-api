class AuctionDecorator < ApplicationDecorator
  def is_favourite?
    object.favourites.find_by(user: self.context[:user]).present?
  end

  def joined?
    object.customers.find_by(id: self.context[:user]&.id).present?
  end

  def paid?
    object.customer_auctions.find_by(user_id: self.context[:user]&.id)&.paid
  end

  def has_voucher?
    object.customer_auctions.find_by(user_id: self.context[:user]&.id)&.voucher&.attached?
  end
end
