module Customer
  class AuctionsController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      auctions = Auction.ransack(params[:q])
      auctions.sorts = 'start_at asc'
      pagy, records = pagy(auctions.result(distinct: true), items: params[:items] || 5, page: params[:page])
      records = AuctionDecorator.decorate_collection(records, context: {user: current_customer_user})
      render json: { auctions: AuctionSerializer.new(records, {include: [:products]}), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def show
      auction = Auction.find(params[:id])
      auction = AuctionDecorator.decorate(auction, context: {user: current_customer_user})
      render json: AuctionSerializer.new(auction, {include: [:products]}), status:200
    end

    def search
      auctions = Auction.ransack(params[:search]).result(distinct: true).limit(10)
      auctions = AuctionDecorator.decorate_collection(auctions, context: { user: current_customer_user })
      render json: {auctions: AuctionSerializer.new(auctions, {include: [:products]})}, status: 200
    end

    def joined
      auctions = current_customer_user.auctions.ransack(params[:q])
      auctions.sorts = 'start_at asc'
      pagy, records = pagy(auctions.result(distinct: true), items: params[:items] || 5, page: params[:page])
      records = AuctionDecorator.decorate_collection(records, context: {user: current_customer_user})
      render json: { auctions: AuctionSerializer.new(records, {include: [:products]}), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def join
      auction = Auction.find(params[:id])
      if current_customer_user.auctions.find_by(id: auction.id)
        render json: {errors: {auction: 'Already joined to this auction'}}, status: 406
      end

      current_customer_user.customer_auctions.create(auction: auction)
      render json: AuctionSerializer.new(auction), status: 201
    end

    def upload_voucher
      auction = Auction.find(params[:id])
      customer_auction = current_customer_user.customer_auctions.find_by(auction_id: auction.id)
      unless customer_auction
        render json: {errors: {auction: 'You don\'t have permissions to upload the voucher for this auction'}}, status: 403
      end

      if customer_auction.voucher.attached?
        render json: {errors: {auction: 'There is already uploaded a voucher for this auction'}}, status: 406
      end

      customer_auction.update(upload_voucher_params)

      auction = AuctionDecorator.decorate(auction, context: { user: current_customer_user })
      render json: AuctionSerializer.new(auction), status: 200
    end

    private

    def upload_voucher_params
      params.require(:auction).permit(:voucher)
    end
  end
end
