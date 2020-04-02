class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end
