module Customer
  class BidsController < ApplicationController
    def create
      bid = Bid.where("current_value >= :value_bid",{ value_bid: bid_params[:current_value] })
               .find_by(product_id: bid_params[:product_id], auction_id: bid_params[:auction_id])
      return render json: { errors: 'There is already a bid for that value for the this product' }, status: 406 if bid

      product = Product.find_by(id: bid_params[:product_id], state: 'bidding')
      return render json: { errors: 'This product is not in the bidding process '}, status: 406 unless product


      bid = current_customer_user.bids.new(bid_params)

      if bid.save
        SendBidAuctionWorker.perform_async(bid.product.auction.id, bid.id)
        render json: {bid: BidSerializer.new(bid,
          {
            include: [:user]
          }
        )}, status: 201
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
        :product_id,
        :auction_id
      )
    end
  end
end
