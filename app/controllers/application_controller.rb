class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

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
      errors: resource.errors,
    }, status: :bad_request
  end

  def generate_pagination_metadata(pagy)
    {
      count: pagy.count,
      items: pagy.items,
      page: pagy.page,
      last: pagy.last,
      pages: pagy.pages,
      from: pagy.from,
      to: pagy.to,
      next: pagy.next,
      prev: pagy.prev
    }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company, :phone])
  end

end
