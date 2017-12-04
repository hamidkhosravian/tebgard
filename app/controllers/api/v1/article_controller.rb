module Api
  module V1
    class ArticleController < ApiController
      before_action :authenticate_user_from_token!

      def index
        articles = wall.articles
        render json: { response: articles, status: 200 }, status: 200
      end

      def show
        param! :uid, String, required: true, blank: false
        article = wall.articles.find_by!(uuid: params[:uid])

        render json: { response: article, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false
        param! :title, String, required: true, blank: false

        article = wall.articles.new
        article.title = params[:title]
        article.body = params[:body]
        article.article_tag_list = params[:tags]
        article.save!

        render json: { response: article, status: 201 }, status: 201
      end

      def update
        param! :uid, String, required: true, blank: false

        article = wall.articles.find_by!(uuid: params[:uid])
        article.title = params[:title] if params[:title]
        article.body = params[:body] if params[:body]
        article.article_tag_list = params[:tags] if params[:tags]
        article.save!

        render json: { response: article, status: 200 }, status: 200
      end

      def destroy
        param! :uid, String, required: true, blank: false

        article = wall.articles.find_by!(uuid: params[:uid])

        render status: 204
      end

      def articles_find_by_tag
        param! :tags, Array, required: true, blank: false

        articles = Article.tagged_with(params[:tags], any: true).order("created_at DESC")

        render json: { response: articles, status: 200 }, status: 200
      end
    end
  end
end
