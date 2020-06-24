class CreateOnSiteUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :on_site_users do |t|
      t.string :number
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :phone
      t.string :email
      t.references :auction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
