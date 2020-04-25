module Customer
  class ArticlesController < ApplicationController
    def index
      articles = Article.ransack(params[:q])
      articles.sorts  = 'name asc'
      pagy, records = pagy(articles.result, items: params[:items] || 5, page: params[:page])
      records = ArticleDecorator.decorate_collection(records, context: {user: current_user})
      render json: { articles: ArticleSerializer.new(records), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def show
      article = Article.find(params[:id])
      article = ArticleDecorator.decorate(article, context: {user: current_user})
      render json: ArticleSerializer.new(article), status: 200
    end
  end
end
