module Api
  module V1
    class PostController < ApiController
      before_action :authenticate_user_from_token!

      def index
        byebug
        posts = wall.posts
        render json: { response: posts, status: 200 }, status: 200
      end

      def show
        param! :uid, String, required: true, blank: false
        post = wall.posts.find_by!(uuid: params[:uid])

        render json: { response: post, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false

        post = wall.posts.new
        post.body = params[:body]

        paperclip = PaperclipService.new(post)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]
        post.save!

        render json: { response: post, status: 201 }, status: 201
      end

      def update
        param! :uid, String, required: true, blank: false

        post = wall.posts.find_by!(uuid: params[:uid])
        post.body = params[:body] if params[:body]

        paperclip = PaperclipService.new(post)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]
        post.post_tag_list = params[:tags] if params[:tags]
        post.save!

        render json: { response: post, status: 200 }, status: 200
      end

      def destroy
        param! :uid, String, required: true, blank: false
        post = wall.posts.find_by!(uuid: params[:uid])

        render status: 204
      end

      def posts_find_by_tag
        param! :tags, Array, required: true, blank: false

        posts = Post.tagged_with(params[:tags], any: true).order("created_at DESC")

        render json: { response: posts, status: 200 }, status: 200
      end
    end
  end
end
