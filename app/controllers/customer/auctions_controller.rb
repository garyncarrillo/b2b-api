module Customer
  class AuctionsController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      auctions = Auction.ransack(params[:q])
      auctions.sorts = 'start_at asc'
      pagy, records = pagy(auctions.result, items: params[:items] || 5, page: params[:page])
      records = AuctionDecorator.decorate_collection(records, context: {user: current_customer_user})
      render json: { auctions: AuctionSerializer.new(records, {include: [:products]}), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def show
      auction = Auction.find(params[:id])
      auction = AuctionDecorator.decorate(auction, context: {user: current_customer_user})
      render json: AuctionSerializer.new(auction), status:200
    end

    def search
      auctions = Auction.ransack(params[:search]).result(distinct: true).limit(10)
      auctions = AuctionDecorator.decorate_collection(auctions, context: { user: current_customer_user })
      render json: {auctions: AuctionSerializer.new(auctions, {include: [:products]})}, status: 200
    end
  end
end
