class AuctionsController < ApplicationController
  def index
    auctions = Auction.ransack(params[:q])
    auctions.sorts = 'name asc'
    pagy, records = pagy(auctions.result, items: params[:items] || 5, page: params[:page])
    render json: { auctions: AuctionSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status:200
  end

  def show
    auction = Auction.find(params[:id])
    render json: AuctionSerializer.new(auction), status:200
  end

  def create
    auction = Auction.new(auction_params)

    if auction.save
      render json: AuctionSerializer.new(auction), status: 201
    else
      render json: {errors: auction.errors.messages}, status: 406
    end
  end

  def update
    auction =  Auction.find(params[:id])

    if auction.update(auction_params)
      render json: AuctionSerializer.new(auction), status: 200
    else
      render json: {errors: auction.errors.messages}, status: 406
    end
  end

  def destroy
    auction =  Auction.find(params[:id])

    begin
      auction.destroy
    rescue => e
      render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
    end
  end

  private
  def auction_params
    params.require(:auction).permit(:name, :start_at)
  end
end
