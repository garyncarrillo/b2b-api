module Admin
  class OnSiteUsersController < ApplicationController
    def index
      users = OnSiteUser.ransack(params[:q])
      users.sorts = 'created_at desc'
      pagy, records = pagy(users.result, items: params[:items] || 5, page: params[:page])
      render json: { auctions: OnSiteUserSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def create
      user = OnSiteUser.new(user_params)

      if user.save
        render json: OnSiteUserSerializer.new(user), status: 201
      else
        render json: {errors: user.errors.messages}, status: 406
      end
    end

    def destroy
      user =  OnSiteUser.find(params[:id])

      begin
        user.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :email, :company, :number, :auction_id)
    end
  end
end
