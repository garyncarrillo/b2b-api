class BidSerializer < BaseSerializer
  attributes :id, :current_value, :value, :product_id, :created_at

  belongs_to :user
  belongs_to :product
  belongs_to :auction
end
