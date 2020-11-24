class AddUuiToAuctions < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :uuid, :string, unique: true
  end
end
