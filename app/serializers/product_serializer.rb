class ProductSerializer < BaseSerializer
  attributes :name, :description, :initial_amount, :bid_amount

  attribute :images do |object|
    object.images.each_with_object([]) do |image, results|
      results << image.service_url
    end
  end

  attribute :is_favourite, if: Proc.new { |record| record.respond_to?(:is_favourite?) } do |object|
    object.is_favourite?
  end

  belongs_to :auction
  belongs_to :article
end
