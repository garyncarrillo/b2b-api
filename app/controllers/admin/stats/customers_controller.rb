module Admin
  class Stats::CustomersController < ApplicationController
    include ActionView::Rendering

    def anality
      @customers = CustomerUser.all
      render xlsx: "customers_report", template: "anality.xlsx.axlsx"
    end

    private

    def render_to_body(options)
      _render_to_body_with_renderer(options) || super
    end
  end
end
