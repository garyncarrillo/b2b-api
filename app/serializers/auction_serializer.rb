class AuctionSerializer < BaseSerializer
  attributes :name, :start_at, :description, :contact_phone,
             :place, :auction_type, :terms_and_conditions

  attribute :is_favourite, if: Proc.new { |record| record.respond_to?(:is_favourite?) } do |object|
    object.is_favourite?
  end

  attribute :joined, if: Proc.new { |record| record.respond_to?(:joined?) } do |object|
    object.joined?
  end

  attribute :paid, if: Proc.new { |record| record.respond_to?(:paid?) } do |object|
    object.paid?
  end

  has_many :products
end
