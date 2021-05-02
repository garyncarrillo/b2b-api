class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :auction
end
