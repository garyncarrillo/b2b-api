module Admin
  class BidsController < ApplicationController
    def create
      bid = Bid.where("value <= :value_bid",{ value_bid: bid_params[:value] })
               .find_by(auction_id: bid_params[:auction_id])
      return render json: { errors: 'There is already a bid for that value in the auction' }, status: 406 if bid

      bid = current_admin_user.bids.new(bid_params)

      if bid.save
        SendBidAuctionWorker.perform_async(bid.id, bid.auction_id)
        render json: BidSerializer.new(bid), status: 201
      else
        render json: { errors: bid.errors.messages }, status: 406
      end
    end

    def index
      bids = Bid.all
      render json: { bids: BidSerializer.new(bids) }, status: 200
    end

    private

    def bid_params
      params.require(:bid).permit(
        :current_value,
        :value,
        :uuid,
        :auction_id
      )
    end
  end
end
