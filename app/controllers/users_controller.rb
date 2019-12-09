class UsersController < ApplicationController
  def show
    render json: UserSerializer.new(current_user), status: 200
  end
end
