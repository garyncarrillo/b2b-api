class ProductFavouritesController < ApplicationController
  def create
    product = Product.find(params[:id])
    favourite = product.favourites.new({user: current_user})

    if favourite.save
      render json: FavouriteSerializer.new(favourite), status: 201
    else
      render json: {errors: favourite.errors.messages}, status: 406
    end
  end

  def destroy
    product = Product.find(params[:id])
    favourite =  product.favourites.find_by_user_id(current_user)

    begin
      favourite.destroy
    rescue => e
      render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
    end
  end
end
