class FavouritesController < ApplicationController
  def index
    favourites = current_user.favourites.ransack(params[:q])
    pagy, records = pagy(favourites.result, items: params[:items] || 5, page: params[:page])
    render json: { favourites: FavouriteSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
  end
end
