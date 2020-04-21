class AuctionSerializer < BaseSerializer
  attributes :name, :start_at, :description, :contact_phone,
             :place, :auction_type, :terms_and_conditions

  attribute :is_favourite do |object|
    object.is_favourite?
  end

  has_many :products
end
