module Admin
  class SellersController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      sellers = Seller.ransack(params[:q])
      sellers.sorts  = 'first_name asc'
      pagy, records = pagy(sellers.result, items: params[:items] || 5, page: params[:page])
      render json: { sellers: SellerSerializer.new(records, { include: [:products] }), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def create
      seller = Seller.new(seller_params)

      if seller.save
        render json: SellerSerializer.new(seller), status: 201
      else
        render json: {errors: seller.errors.messages}, status: 406
      end
    end

    def update
      seller = Seller.find(params[:id])

      seller.assign_attributes(seller_params)

      if seller_params[:profile_picture].present?
        seller.assign_attributes(profile_picture: seller_params[:profile_picture])
      else
        unless seller_params.has_key?(:profile_picture)
          seller.profile_picture.purge
        end
      end

      if seller.save
        render json: SellerSerializer.new(seller), status: 200
      else
        render json: {errors: seller.errors.messages}, status: 406
      end
    end

    def destroy
      seller = Seller.find(params[:id])
      begin
        seller.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private
    def seller_params
      params.require(:seller).permit(
        :first_name,
        :last_name,
        :profile_picture
      )
    end
  end
end
