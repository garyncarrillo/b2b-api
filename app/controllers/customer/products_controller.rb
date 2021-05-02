module Customer
  class ProductsController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      products = Product.ransack(params[:q])
      products.sorts  = 'name asc'
      pagy, records = pagy(products.result, items: params[:items] || 5, page: params[:page])
      records = ProductDecorator.decorate_collection(records, context: {user: current_customer_user})
      render json: { products: ProductSerializer.new(records, { include: [:article, :'article.category', :seller] }), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def show
      product = Product.find(params[:id])
      product = ProductDecorator.decorate(product, context: {user: current_customer_user})
      render json: ProductSerializer.new(product, { include: [:article, :'article.category', :seller] }), status: 200
    end

    def last_bid
      bids =  Product.find(params[:id]).bids.where(auction_id: params[:auction_id])
      render json: { bid: BidSerializer.new( bids.last) }, status: 200
    end

    def bids
      bids =  Product.find(params[:id]).bids.where(auction_id: params[:auction_id])
      render json: { bids: BidSerializer.new(bids,
        {
          include: [:user]
        }
      ) }, status: 200
    end
  end
end
