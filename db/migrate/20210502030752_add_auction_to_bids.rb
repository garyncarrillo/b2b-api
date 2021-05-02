class AddAuctionToBids < ActiveRecord::Migration[6.0]
  def change
    add_reference :bids, :auction, null: false, foreign_key: true
  end
end
