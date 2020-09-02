class CategorySerializer < BaseSerializer
  attributes :name, :description

  has_many :articles
end
