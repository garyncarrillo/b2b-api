class SellerSerializer < BaseSerializer
  attributes :first_name, :last_name

  attribute :image do |object|
     object.profile_picture.service_url if object.profile_picture.attached?
  end

  has_many :products
end
