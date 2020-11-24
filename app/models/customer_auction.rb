class CustomerAuction < ApplicationRecord
  ON_SITE = 'on_site'
  ON_LINE = 'on_line'

  has_one_attached :voucher
  belongs_to :customer, class_name: 'User', foreign_key: :user_id
  belongs_to :auction
end
