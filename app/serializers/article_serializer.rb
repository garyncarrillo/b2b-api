class ArticleSerializer < BaseSerializer
  attributes :name, :category_id

  belongs_to :category
end
