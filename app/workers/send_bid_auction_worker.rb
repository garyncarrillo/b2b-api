class SendBidAuctionWorker
  include Sidekiq::Worker

  def perform(auction_id, id)
    auction = Auction.find(auction_id)
    bid = Bid.find(id)

    message = {
      room: auction.uuid,
      data: {
        auction_id: auction.id,
        bid_id: bid.id,
        product_id: bid.product.id,
        bid_current_value: bid.current_value,
        bid_vale: bid.value,
        create_at: bid.created_at,
        role: bid.user.role,
        first_name: bid.user.first_name,
        last_name: bid.user.last_name
      }
    }.to_json

    REDIS_INSTANCE.publish 'auction-bids-channel', message
  end
end
