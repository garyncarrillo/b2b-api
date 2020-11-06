class BidSerializer < BaseSerializer
  attributes :id, :uuid, :current_value, :value, :product_id

  belongs_to :user
  belongs_to :product
end
