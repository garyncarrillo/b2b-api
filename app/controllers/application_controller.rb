class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :authenticate_user!

  def render_resource(resource)
    if resource.errors.empty?
      render json: UserSerializer.new(resource)
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
