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
        article = wall.article.find_by(uuid: params[:uid])

        render json: { response: article, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false
        article = wall.article.create!(body: params[:body])

        render json: { response: article, status: 201 }, status: 201
      end

      def update
        param! :uid, String, required: true, blank: false
        article = wall.article.find_by(uuid: params[:uid])
        article.body = params[:body] if params[:params]
        article.save!

        render json: { response: article, status: 200 }, status: 200
      end

      def delete
        param! :uid, String, required: true, blank: false
        article = wall.article.find_by(uuid: params[:uid])

        render status: 204
      end
    end
  end
end
