module Admin
  class ProductsController < ApplicationController
    before_action do
      ActiveStorage::Current.host = ENV['ACTIVE_STORAGE_HOST']
    end

    def index
      products = Product.ransack(params[:q])
      products.sorts  = 'name asc'
      pagy, records = pagy(products.result, items: params[:items] || 5, page: params[:page])
      render json: { products: ProductSerializer.new(records, {include: [:article, :'article.category', :seller]} ), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def show
      product = Product.find(params[:id])
      render json: ProductSerializer.new(product, {include: [:article, :'article.category', :seller]}), status: 200
    end

    def create
      product = Product.new(product_params.merge(product_attachments_params.select{|_, v| !v.blank?}))

      if product.save
        render json: ProductSerializer.new(product), status: 201
      else
        render json: {errors: product.errors.messages}, status: 406
      end
    end

    def update
      product =  Product.find(params[:id])

      product.assign_attributes(product_params)

      if product_attachments_params[:attached_1_file].present?
        product.assign_attributes(attached_1_file: product_attachments_params[:attached_1_file])
      elsif product_attachments_params.has_key?(:attached_1_file)
        product.attached_1_file.purge
      end

      if product_attachments_params[:attached_2_file].present?
        product.assign_attributes(attached_2_file: product_attachments_params[:attached_2_file])
      elsif product_attachments_params.has_key?(:attached_2_file)
        product.attached_2_file.purge
      end

      if product_attachments_params[:images].present?
        product.assign_attributes(images: product_attachments_params[:images])
      end

      if (product_attachments_params[:removed_images].present?)
        product.images.where(blob_id: product_attachments_params[:removed_images]).purge
      end

      if product.save
        render json: ProductSerializer.new(product), status: 200
      else
        render json: {errors: product.errors.messages}, status: 406
      end
    end

    def destroy
      product =  Product.find(params[:id])

      begin
        product.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private
    def product_params
      params.require(:product).permit(
        :name,
        :description,
        :initial_amount,
        :bid_amount,
        :tax_included,
        :place_of_delivery,
        :currency,
        :quantity,
        :unit_of_measure,
        :auction_id,
        :article_id,
        :seller_id,
      )
    end

    def product_attachments_params
      params.require(:product).permit(
        :attached_1_file,
        :attached_2_file,
        images: [ ],
        removed_images: [ ]
      )
    end
  end
end
