module Admin
  class InvitationsController < Devise::InvitationsController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    private
    def respond_with(resource, _opts = {})
      if resource.errors.empty?
        render json: UserSerializer.new(resource)
      else
        validation_error(resource)
      end
    end
  end
end
