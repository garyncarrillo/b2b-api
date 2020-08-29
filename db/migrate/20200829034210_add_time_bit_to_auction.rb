class AddTimeBitToAuction < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :time_bit, :integer
  end
end
