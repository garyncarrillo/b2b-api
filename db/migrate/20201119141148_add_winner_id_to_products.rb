class AddWinnerIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :winner_id, :bigint
  end
end
