module Api
  module V1
    class ArticleController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_article, except: [:index, :create, :articles_find_by_tag]

      def index
        articles = wall.articles
        authorize articles
        render json: { response: articles, status: 200 }, status: 200
      end

      def show
        render json: { response: @article, status: 200 }, status: 200
      end

      def create
        param! :body, String, required: true, blank: false
        param! :title, String, required: true, blank: false

        article = wall.articles.new
        authorize article

        article.title = params[:title]
        article.body = params[:body]
        article.article_tag_list = params[:tags]
        article.save!

        render json: { response: article, status: 201 }, status: 201
      end

      def update
        @article.title = params[:title] if params[:title]
        @article.body = params[:body] if params[:body]
        @article.article_tag_list = params[:tags] if params[:tags]
        @article.save!

        render json: { response: @article, status: 200 }, status: 200
      end

      def destroy
        @article.destroy!
        render status: 204
      end

      def upload_file
        paperclip = PaperclipService.new(@article)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]

        render json: { response: @article, status: 200 }, status: 200
      end

      def comments
        render json: { response: @article.comments, status: 200 }, status: 200
      end

      def add_comment
        param! :body, String, required: true, blank: false

        comment = @article.comments.create!(body: params[:body], wall: wall)
        render json: { response: comment, status: 201 }, status: 201
      end

      def like
        @article.liked_by current_user.profile
        render json: {response: "like article.", status: 201 }
      end

      def unlike
        @article.unliked_by current_user.profile
        render json: {response: "unlike article.", status: 204}, status: 204
      end

      def wall_articles
        param! :uid, String, required: true, blank: false

        wall = Wall.find_by(uuid: params[:uid])
        articles = wall.articles
        authorize articles

        render json: { response: articles, status: 200 }, status: 200
      end

      def articles_find_by_tag
        param! :tags, Array, required: true, blank: false

        articles = Article.tagged_with(params[:tags], any: true).order("created_at DESC")
        authorize articles

        render json: { response: articles, status: 200 }, status: 200
      end

      private
        def set_article
          param! :uid, String, required: true, blank: false
          @article = Article.find_by(uuid: params[:uid])
          authorize @article
        end
    end
  end
end
