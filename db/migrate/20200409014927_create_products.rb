class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :initial_amount
      t.decimal :bid_amount
      t.references :article, null: false, foreign_key: true
      t.references :auction, foreign_key: true

      t.timestamps
    end
  end
end
