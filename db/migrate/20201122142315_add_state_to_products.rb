class AddStateToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :state, :string, deafult: 'initial'
  end
end
