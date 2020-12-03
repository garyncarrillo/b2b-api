class SendBidAuctionWorker
  include Sidekiq::Worker

  def perform(auction_id, id)
    auction = Auction.find(auction_id)
    bid = Bid.find(id)

    message = {
      room: auction.uuid,
      data: {
        auction_id: auction.id,
        bid: bid.current_value,
        bid: bid.value
      }
    }.to_json

    REDIS_INSTANCE.publish 'auction-bids-channel', message
  end
end
