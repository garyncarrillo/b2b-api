class ChangeColumnTypeForStartAtInAuctions < ActiveRecord::Migration[6.0]
  def up
    remove_column :auctions, :start_at
    add_column :auctions, :start_at, :datetime
  end

  def down
    remove_column :auctions, :start_at
    add_column :auctions, :start_at, :decimal
  end
end
