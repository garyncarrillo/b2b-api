module Admin
  class CustomersController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def approve_pay
      customer_auction = CustomerAuction.find(params[:id])

      if customer_auction.update(paid: true)
        render json: {}, status: 200
      else
        render json: { erros: customer_auction.errors.messages }, status: 406
      end
    end

    def index
      customers = CustomerUser.ransack(params[:q])
      pagy, records = pagy(customers.result, items: params[:items] || 5, page: params[:page])
      render json: { customers: CustomerSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def search
      customer = CustomerUser.find_by(identification_number: params[:identification_number])
      render json: { customer: OnSiteUserSerializer.new(customer) }, status: 200
    end

    def activate
      customer = CustomerUser.find(params[:id])
      customer.active = true

      if customer.save
        render json: { customer: CustomerSerializer.new(customer) }, status: 200
      else
        render json: { errors: customer.errors.messages }, status: 200
      end
    end

    def deactivate
      customer = CustomerUser.find(params[:id])
      customer.active = false

      if customer.save
        render json: { customer: CustomerSerializer.new(customer) }, status: 200
      else
        render json: { errors: customer.errors.messages }, status: 200
      end
    end
  end
end
