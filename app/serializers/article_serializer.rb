class ArticleSerializer < BaseSerializer
  attributes :name, :category_id

  attribute :is_favourite, if: Proc.new { |record| record.respond_to?(:is_favourite?) } do |object|
    object.is_favourite?
  end

  belongs_to :category
end
