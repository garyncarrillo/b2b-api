class FavouriteSerializer < BaseSerializer
  belongs_to :favouritable, polymorphic: { Auction: :auction, Product: :product }
  belongs_to :user
end
