class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

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

  def not_found(exception)
    exception.to_s.match(/Couldn't find ([\w]+) with 'id'=([\d]+)/)
    render json: {status: 404, errors: {$1 => ["#{$1} with id #{$2} was not found"]}}, status: 404
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company, :phone])
  end

end
