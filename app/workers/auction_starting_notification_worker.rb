class AuctionStartingNotificationWorker
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    auction.update(uuid: SecureRandom.uuid)

    message = {
      room: "743a6538-74ba-41a2-ad9c-e89f3c9ead80",
      data: {
        auction_id: auction_id,
        auction: auction.name
      }
    }.to_json

    REDIS_INSTANCE.publish 'bus-tracking', message
  end
end
