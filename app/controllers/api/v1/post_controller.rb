module Api
  module V1
    class PostController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_post, except: [:index, :create, :posts_find_by_tag]

      def index
        posts = wall.posts
        authorize posts

        render json: { response: posts, status: 200 }, status: 200
      end

      def show
        render json: { response: @post, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false

        post = wall.posts.new
        authorize post

        post.body = params[:body]
        post.post_tag_list = params[:tags]

        paperclip = PaperclipService.new(post)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]
        post.save!

        render json: { response: post, status: 201 }, status: 201
      end

      def update
        @post.body = params[:body] if params[:body]
        @post.post_tag_list = params[:tags] if params[:tags]

        paperclip = PaperclipService.new(@post)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]
        @post.post_tag_list = params[:tags] if params[:tags]
        @post.save!

        render json: { response: @post, status: 200 }, status: 200
      end

      def destroy
        @post.destroy!
        render status: 204
      end

      def comments
        render json: { response: @post.comments, status: 200 }, status: 200
      end

      def add_comment
        comment = @post.comments.create!(body: params[:body], wall: wall)
        render json: { response: comment, status: 201 }, status: 201
      end

      def like
        @post.liked_by current_user.profile

        render json: {response: "like post.", status: 201 }
      end

      def unlike
        @post.unliked_by current_user.profile
        render json: {response: "unlike post.", status: 204}, status: 204
      end

      def posts_find_by_tag
        param! :tags, Array, required: true, blank: false

        posts = Post.tagged_with(params[:tags], any: true).order("created_at DESC")
        authorize posts

        render json: { response: posts, status: 200 }, status: 200
      end

      private
        def set_post
          param! :uid, String, required: true, blank: false
          @post = Post.find_by(uuid: params[:uid])
          authorize @post
        end
    end
  end
end
