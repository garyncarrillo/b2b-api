class AddStateToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :state, :string, default: 'initial'
  end
end
