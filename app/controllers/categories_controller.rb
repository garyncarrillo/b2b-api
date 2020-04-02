class CategoriesController < ApplicationController

  def index
    categories = Category.ransack(params[:q])
    categories.sorts  = ' name asc'
    pagy, records = pagy(categories.result, items: params[:items] || 5, page: params[:page])
    render json: { categories: CategorySerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
  end

  def show
    category =  Category.find(params[:id])
    render json: CategorySerializer.new(category), status: 200
  end

  def create
    category = Category.new(category_params)

    if category.save
      render json: CategorySerializer.new(category), status: 201
    else
      render json: {errors: category.errors.messages}, status: 406
    end
  end

  def update
    category =  Category.find(params[:id])

    if category.update(category_params)
      render json: CategorySerializer.new(category), status: 200
    else
      render json: {errors: category.errors.messages}, status: 406
    end
  end

  def destroy
    category =  Category.find(params[:id])
    
    begin
      category.destroy
    rescue => e
      render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
    end
  end

  private
  def category_params
      params.require(:category).permit(:name, :description)
  end
end
