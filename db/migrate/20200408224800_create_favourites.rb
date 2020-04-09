class CreateFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :favourites do |t|
      t.string :favouritable_type
      t.bigint :favouritable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
