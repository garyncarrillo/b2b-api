module Admin
  class AuctionsController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      auctions = Auction.ransack(params[:q])
      auctions.sorts = 'start_at desc'
      pagy, records = pagy(auctions.result, items: params[:items] || 5, page: params[:page])
      render json: { auctions: AuctionSerializer.new(records, {include: [:products]}), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def show
      auction = Auction.find(params[:id])
      render json: AuctionSerializer.new(auction, {include: [:products]}), status: 200
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
        render json: {}, status: 204
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    def publish
      auction = Auction.find(params[:id])
      auction.publish!
      render json: AuctionSerializer.new(auction), status: 200
    end

    def assign_products
      auction = Auction.find(params[:id])
      Product.where(auction_id: auction.id).update_all(auction_id: nil)
      if auction_assign_product_params[:products_id].any?
        Product.where(id: auction_assign_product_params[:products_id]).update_all(auction_id: auction.id)
      end
      render json: {}, status: 200
    end

    def customers
      customers = Auction.find(params[:id]).customer_auctions.ransack(params[:q])
      pagy, records = pagy(customers.result, items: params[:items] || 5, page: params[:page])
      render json: { customer_auctions: CustomerAuctionSerializer.new(records,
      {
        include: [:auction, :customer]
      }), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def approve_pay
      customer_auction = CustomerAuction.find(params[:id])

      if customer_auction.update(paid: true)
        render json: {}, status: 200
      else
        render json: { erros: customer_auction.errors.messages }, status: 406
      end
    end

    def start
      auction = Auction.find(params[:id])
      auction.start!
      render json: AuctionSerializer.new(auction, {include: [:products]}), status: 200
    end

    def finish
      auction = Auction.find(params[:id])
      auction.finish!
      render json: AuctionSerializer.new(auction, {include: [:products]}), status: 200
    end

    private

    def auction_params
      params.require(:auction).permit(
        :name,
        :description,
        :contact_phone,
        :place,
        :auction_type,
        :terms_and_conditions,
        :start_at,
        :time_bit,
        :terms_and_conditions_file,
        :products_report_file
      ).tap do |auction_params|
        auction_params.delete(:terms_and_conditions_file) if !auction_params[:terms_and_conditions_file]
        auction_params.delete(:products_report_file) if !auction_params[:products_report_file]
      end
    end

    def auction_assign_product_params
      params.require(:auction).permit(products_id: [])
    end
  end
end
