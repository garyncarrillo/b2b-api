module Admin
  class CustomersController < ApplicationController
    def approve_pay
      customer_auction = CustomerAuction.find(params[:id])

      if customer_auction.update(paid: true)
        render json: {}, status: 200
      else
        render json: { erros: customer_auction.errors.messages }, status: 406
      end
    end
  end
end
