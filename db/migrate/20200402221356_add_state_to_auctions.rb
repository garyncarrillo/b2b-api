class AddStateToAuctions < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :state, :string
  end
end
