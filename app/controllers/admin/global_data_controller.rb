module Admin
  class GlobalDataController < ApplicationController
    def show
      render json: {
        categories: CategorySerializer.new(Category.all),
      }, status: 200
    end
  end
end
