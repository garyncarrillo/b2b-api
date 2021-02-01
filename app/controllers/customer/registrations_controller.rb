module Customer
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
      build_resource(sign_up_params)
      if resource.save
        sign_in(resource)
      end
      render_resource(resource)
    end

    private

    def sign_up_params
      params.require(:customer_user).permit(
        :first_name,
        :last_name,
        :identification_number,
        :company,
        :email,
        :password,
        :phone
      )
    end
  end
end
