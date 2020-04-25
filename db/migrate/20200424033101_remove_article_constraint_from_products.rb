class RemoveArticleConstraintFromProducts < ActiveRecord::Migration[6.0]
  def up
    change_column :products, :article_id, :bigint, null: true
    remove_foreign_key :products, :articles
  end
  def down
    change_column :products, :article_id, :bigint, null: false
    add_foreign_key :products, :articles
  end
end
