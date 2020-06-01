class AddStartedToAuction < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :started, :boolean, default: false
  end
end
