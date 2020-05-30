module Customer
  class FavouritesController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      favourites = current_customer_user.favourites.ransack(params[:q])
      pagy, records = pagy(favourites.result(distinct: true), items: params[:items] || 5, page: params[:page])
      render json: { favourites: FavouriteSerializer.new(records, { include: [:favouritable, :'favouritable.product.article', :'favouritable.product.article.category', :'favouritable.product.seller'] }), metadata: generate_pagination_metadata(pagy) }, status: 200
    end
  end
end
