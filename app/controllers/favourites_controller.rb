class FavouritesController < ApplicationController
  def index
    favourites = Favourite.ransack({favouritable_type_cont: params[:q], user_id_eq: current_user.id})
    pagy, records = pagy(favourites.result, items: params[:items] || 5, page: params[:page])
    render json: { articles: FavouriteSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
  end
end
