class AddMissingAttributesForProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :tax_included, :boolean, default: false
    add_column :products, :currency, :integer, default: 0
    add_column :products, :quantity, :integer
    add_column :products, :unit_of_measure, :integer, default: 0
    add_column :products, :place_of_delivery, :string
  end
end
