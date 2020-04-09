class ArticleSerializer < BaseSerializer
  attributes :name, :category_id

  attribute :is_favourite do |object|
    object.is_favourite?
  end
  
  belongs_to :category
end
