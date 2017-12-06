module Api
  module V1
    class CommentController < ApiController
      def destroy
        param! :uid, String, required: true, blank: false
        comment = Comment.find_by!(uuid: params[:uid])
        comment.destroy

        render status: 204
      end
    end
  end
end
