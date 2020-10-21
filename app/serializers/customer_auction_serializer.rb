class CustomerAuctionSerializer < BaseSerializer
  attributes :id, :user_id, :auction_id, :paid

  belongs_to :auction
  belongs_to :customer, class_name: 'User', id_method_name: :user_id

  attribute :voucher do |object|
     object.voucher.service_url if object.voucher.attached?
  end
end
