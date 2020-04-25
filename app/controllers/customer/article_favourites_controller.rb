module Customer
  class ArticleFavouritesController < ApplicationController
    def create
      article = Article.find(params[:id])
      favourite = article.favourites.new({user: current_user})

      if favourite.save
        render json: FavouriteSerializer.new(favourite), status: 201
      else
        render json: {errors: favourite.errors.messages}, status: 406
      end
    end

    def destroy
      article = Article.find(params[:id])
      favourite =  article.favourites.find_by_user_id(current_user)

      begin
        favourite.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end
  end
end
