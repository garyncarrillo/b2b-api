class AuctionSerializer < BaseSerializer
  attributes :name, :start_at, :description, :contact_phone,
             :place, :auction_type, :terms_and_conditions, :started, :state, :time_bit

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

  attribute :terms_and_conditions_file do |object|
     object.terms_and_conditions_file.service_url if object.terms_and_conditions_file.attached?
  end

  attribute :terms_and_conditions_file_name do |object|
    object.terms_and_conditions_file.blob.filename if object.terms_and_conditions_file.attached?
  end

  attribute :terms_and_conditions_file_size do |object|
    object.terms_and_conditions_file.blob.byte_size if object.terms_and_conditions_file.attached?
  end

  attribute :products_report_file do |object|
     object.products_report_file.service_url if object.products_report_file.attached?
  end

  attribute :products_report_file_name do |object|
    object.products_report_file.blob.filename if object.products_report_file.attached?
  end

  attribute :products_report_file_size do |object|
    object.products_report_file.blob.byte_size if object.products_report_file.attached?
  end

  has_many :products
end
