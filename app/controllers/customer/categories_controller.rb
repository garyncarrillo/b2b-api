module Customer
  class CategoriesController < ApplicationController
    def index
      categories = Category.ransack(params[:q])
      categories.sorts  = 'name asc'
      pagy, records = pagy(categories.result, items: params[:items] || 5, page: params[:page])
      render json: { categories: CategorySerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def show
      category =  Category.find(params[:id])
      render json: CategorySerializer.new(category), status: 200
    end
  end
end
