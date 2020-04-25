module Customer
  class UserController < ApplicationController
    def show
      render json: UserSerializer.new(current_user), status: 200
    end

    def update
      current_user.assign_attributes(user_params)

      if current_user.save
        render json: UserSerializer.new(current_user), status: 200
      else
        render json: {errors: current_user.errors.messages}, status: 406
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :email, :company, :password)
    end
  end
end
