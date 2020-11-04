class AuctionStartingNotificationWorker
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    auction.update(uuid: SecureRandom.uuid)

    message = {
      rooms: auction.customers.pluck(:uuid),
      data: {
        auction_id: auction_id,
        auction: auction.name
      }
    }.to_json

    REDIS_INSTANCE.publish 'bus-tracking', message
  end
end
