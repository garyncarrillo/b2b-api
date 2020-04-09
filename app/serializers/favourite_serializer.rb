class FavouriteSerializer < BaseSerializer
  attributes :favouritable_type, :favouritable_id

  belongs_to :user
end
