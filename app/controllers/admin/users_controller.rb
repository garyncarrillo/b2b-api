module Admin
  class UsersController < ApplicationController
    def index
      users = AdminUser.ransack(params[:q])
      users.sorts  = 'first_name asc'
      pagy, records = pagy(users.result, items: params[:items] || 5, page: params[:page])
      render json: { users: UserSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def create
      user = AdminUser.create(admin_params)

      if user.save
        user.invite!
        render json: { user: UserSerializer.new(user) }, status: 200
      else
        render json: { errors: user.errors.messages }, status: 406
      end
    end

    def update
      user =  AdminUser.find(params[:id])

      if user.update(admin_params)
        render json: { user: UserSerializer.new(user)}, status: 200
      else
        render json: { errors: user.errors.messages }, status: 406
      end
    end

    def destroy
      user =  AdminUser.find(params[:id])

      begin
        user.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private

    def admin_params
      params.require(:admin).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :role
      )
    end
  end
end
