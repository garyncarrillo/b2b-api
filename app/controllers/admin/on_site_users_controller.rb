module Admin
  class OnSiteUsersController < ApplicationController
    def index
      users = CustomerUser.includes(:on_site_customer_auctions)
                          .where(customer_auctions: { auction_id: params[:auction_id] })
                          .ransack(params[:q])
      users.sorts = 'created_at desc'
      pagy, records = pagy(users.result, items: params[:items] || 5, page: params[:page])
      render json: { auctions: OnSiteUserSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status:200
    end

    def create
      user = CustomerUser.new(
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        phone: user_params[:phone],
        email: user_params[:email],
        company: user_params[:company],
        identification_number: user_params[:identification_number],
        active: false
      )

      if user.save
        auction = Auction.find(user_params[:auction_id])

        user.customer_auctions.create({
          auction: auction,
          palette_number: user_params[:palette_number],
          ubication: CustomerAuction::ON_SITE
        })
        render json: OnSiteUserSerializer.new(user), status: 201
      else
        render json: {errors: user.errors.messages}, status: 406
      end
    end

    def destroy
      user =  CustomerUser.find(params[:id])

      begin
        user.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    def verify
      user = CustomerUser.includes(:on_site_customer_auctions)
                         .where(customer_auctions: {auction_id: params[:auction_id]})
                         .find_by(identification_number: params[:identification_number])
      render json: { on_site_user: OnSiteUserSerializer.new(user) }, status: 200
    end

    def assign_palette
      on_site_user = CustomerUser.find(params[:id])
      auction = Auction.find(assign_palette_params[:auction_id])

      assign_palette = on_site_user.customer_auctions.new({
        auction: auction,
        palette_number: assign_palette_params[:palette_number],
        ubication: CustomerAuction::ON_SITE
      })

      if assign_palette.save
        render json: { on_site_user: OnSiteUserSerializer.new(on_site_user) }, status: 200
      else
        render json: { on_site_user: assign_palette.errors.messages }, status: 406
      end
    end

    def unassign_palette
      on_site_user = CustomerUser.find(params[:id])
      assign_palette = on_site_user.on_site_customer_auctions.find_by(auction_id: params[:auction_id])

      begin
        assign_palette.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :phone,
        :email,
        :company,
        :identification_number,
        :palette_number,
        :auction_id)
    end

    def assign_palette_params
      params.require(:user).permit(:palette_number,:auction_id)
    end
  end
end
