module Api
  module V1
    class PostController < ApiController
      before_action :authenticate_user_from_token!

      def index
        posts = wall.posts
        render json: { response: posts, status: 200 }, status: 200
      end

      def show
        param! :uid, String, required: true, blank: false
        post = wall.post.find_by(uuid: params[:uid])

        render json: { response: post, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false
        post = wall.post.create!(body: params[:body])

        render json: { response: post, status: 201 }, status: 201
      end

      def update
        param! :uid, String, required: true, blank: false
        post = wall.post.find_by(uuid: params[:uid])
        post.body = params[:body] if params[:params]
        post.save!

        render json: { response: post, status: 200 }, status: 200
      end

      def delete
        param! :uid, String, required: true, blank: false
        post = wall.post.find_by(uuid: params[:uid])

        render status: 204
      end
    end
  end
end
