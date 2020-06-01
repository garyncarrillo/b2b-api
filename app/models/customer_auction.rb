class CustomerAuction < ApplicationRecord
  has_one_attached :voucher
  belongs_to :customer, class_name: 'User', foreign_key: :user_id
  belongs_to :auction
end
