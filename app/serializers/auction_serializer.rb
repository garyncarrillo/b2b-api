class AuctionSerializer < BaseSerializer
  attributes :name, :start_at

  attribute :is_favourite do |object|
    object.is_favourite?
  end

  has_many :products
end
