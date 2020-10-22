module Customer
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
    # unless request.format == :json
    #     sign_out
    #     render status: 406,
    #              json: { message: "JSON requests only." } and return
    # end
    #
    # resource = warden.authenticate!(auth_options)
    # if resource.blank?
    #   render status: 401, json: { response: "Access denied." } and return
    # end
    # resource.devices.destroy_all
    # resource.devices.create(device_params)
    # sign_in(resource, store: false)
    # render json: UserSerializer.new(resource).as_json.merge({jwt: current_token }), status: 200
      super
    end

    private

    def respond_with(resource, _opts = {})
      render_resource(resource)
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
