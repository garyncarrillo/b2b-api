module Admin
  class ArticlesController < ApplicationController
    def index
      articles = Article.ransack(params[:q])
      articles.sorts  = 'name asc'
      pagy, records = pagy(articles.result, items: params[:items] || 5, page: params[:page])
      render json: { articles: ArticleSerializer.new(records,
        {
          include: [:category]
        }
        ), metadata: generate_pagination_metadata(pagy) }, status: 200
    end

    def create
      article = Article.new(article_params)

      if article.save
        render json: ArticleSerializer.new(article), status: 201
      else
        render json: {errors: article.errors.messages}, status: 406
      end
    end

    def update
      article =  Article.find(params[:id])

      if article.update(article_params)
        render json: ArticleSerializer.new(article), status: 200
      else
        render json: {errors: article.errors.messages}, status: 406
      end
    end

    def destroy
      article =  Article.find(params[:id])

      begin
        article.destroy
      rescue => e
        render json: {errors: {base: I18n.t(:cant_be_deleted)}}, status: 406
      end
    end

    private

    def article_params
      params.require(:article).permit(:name, :category_id)
    end
  end
end
