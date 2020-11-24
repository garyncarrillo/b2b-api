class AddReferencesWinnerIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :products, :users, column: :winner_id
  end
end
