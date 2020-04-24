class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :sellers, [:first_name, :last_name], unique: true
  end
end
