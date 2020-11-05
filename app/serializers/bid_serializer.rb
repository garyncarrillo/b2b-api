class BidSerializer < BaseSerializer
  attributes :id, :uuid, :current_value, :value

  belongs_to :auction
  belongs_to :user
end
