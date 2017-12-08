module Api
  module V1
    class CommentController < ApiController
      before_action :set_comment

      def destroy
        @comment.destroy
        render status: 204
      end

      private
        def set_comment
          param! :uid, String, required: true, blank: false
          @comment = Comment.find_by!(uuid: params[:uid])
          authorize @comment
        end
    end
  end
end
