class AddPaletteNumberAndUbicationToCustomerAuctions < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_auctions, :palette_number, :string
    add_column :customer_auctions, :ubication, :string
  end
end
