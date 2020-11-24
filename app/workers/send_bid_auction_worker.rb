class SendBidAuctionWorker
  include Sidekiq::Worker

  def perform(*args)
    auction = Auction.find(auction_id)
    bid = Bid.find(id)

    message = {
      rooms: auction.uuid,
      data: {
        auction_id: auction_id,
        bid: bid.current_value,
        bid: bid.value
      }
    }.to_json

    REDIS_INSTANCE.publish 'auction-bids-channel', message
  end
end
