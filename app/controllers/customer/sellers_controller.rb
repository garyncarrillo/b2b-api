module Customer
  class SellersController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def show
      seller = Seller.find(params[:id])
      render json: SellerSerializer.new(seller, {include: [:products, :'products.article', :'products.article.category']}), status: 200
    end
  end
end
