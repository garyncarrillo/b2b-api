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

end
