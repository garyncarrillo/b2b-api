class ProductSerializer < BaseSerializer
  attributes :name, :description, :initial_amount, :bid_amount, :tax_included,
             :currency, :quantity, :unit_of_measure, :place_of_delivery

  attribute :images do |object|
    object.images.each_with_object([]) do |image, results|
      results << image.service_url
    end
  end

  attribute :is_favourite, if: Proc.new { |record| record.respond_to?(:is_favourite?) } do |object|
    object.is_favourite?
  end

  attribute :attached_1_file do |object|
     object.attached_1_file.service_url if object.attached_1_file.attached?
  end

  attribute :attached_1_file_name do |object|
    object.attached_1_file.blob.filename if object.attached_1_file.attached?
  end

  attribute :attached_1_file_size do |object|
    object.attached_1_file.blob.byte_size if object.attached_1_file.attached?
  end

  attribute :attached_2_file do |object|
     object.attached_2_file.service_url if object.attached_2_file.attached?
  end

  attribute :attached_2_file_name do |object|
    object.attached_2_file.blob.filename if object.attached_2_file.attached?
  end

  attribute :attached_2_file_size do |object|
    object.attached_2_file.blob.byte_size if object.attached_2_file.attached?
  end

  belongs_to :auction
  belongs_to :article
  belongs_to :seller
end
