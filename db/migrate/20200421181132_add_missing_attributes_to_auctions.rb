class AddMissingAttributesToAuctions < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :description, :text
    add_column :auctions, :contact_phone, :string
    add_column :auctions, :place, :string
    add_column :auctions, :auction_type, :integer
    add_column :auctions, :terms_and_conditions, :text
  end
end
