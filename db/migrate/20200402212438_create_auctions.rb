class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.string :name
      t.decimal :start_at

      t.timestamps
    end
  end
end
