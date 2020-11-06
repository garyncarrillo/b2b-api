class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :uuid, null: false
      t.decimal :current_value, null: false
      t.decimal :value, null: false

      t.timestamps
    end
  end
end
