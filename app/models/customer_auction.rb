class CustomerAuction < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: :user_id
  belongs_to :auction
end
