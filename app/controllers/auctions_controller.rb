class AuctionsController < ApplicationController
  def index
    auctions = Auction.ransack(params[:q])
    auctions.sorts = 'start_at asc'
    pagy, records = pagy(auctions.result, items: params[:items] || 5, page: params[:page])
    records = AuctionDecorator.decorate_collection(records, context: {user: current_user})
    render json: { auctions: AuctionSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status:200
  end

  def show
    auction = Auction.find(params[:id])
    auction = AuctionDecorator.decorate(auction, context: {user: current_user})
    render json: AuctionSerializer.new(auction), status:200
  end

  def search
    auctions = Auction.ransack({products_article_name_cont: params[:search]}).result.limit(10)
    auctions = AuctionDecorator.decorate_collection(auctions, context: { user: current_user })
    render json: {auctions: AuctionSerializer.new(auctions)}, status: 200
  end
end
