class AuctionSerializer < BaseSerializer
  attributes :name, :start_at, :description, :contact_phone,
             :place, :auction_type, :terms_and_conditions, :started, :state

  attribute :is_favourite, if: Proc.new { |record| record.respond_to?(:is_favourite?) } do |object|
    object.is_favourite?
  end

  attribute :joined, if: Proc.new { |record| record.respond_to?(:joined?) } do |object|
    object.joined?
  end

  attribute :paid, if: Proc.new { |record| record.respond_to?(:paid?) } do |object|
    object.paid?
  end

  attribute :has_voucher, if: Proc.new { |record| record.respond_to?(:has_voucher?) } do |object|
    object.has_voucher?
  end

  has_many :products
end
