class CreateCustomerAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_auctions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true
      t.boolean :paid, default: false
      t.timestamps
    end
  end
end
