module Api
  module V1
    class FileController < ApiController
      before_action :authenticate_user_from_token!

      def delete_file
        file = nil
        if params[:image]
          file = Picture.find_by(id: params[:image])
        elsif params[:document]
          file = Document.find_by(id: params[:document])
        elsif params[:image]
          file = Picture.find_by(id: params[:image])
        end

        file&.destroy!
        render status: 204
      end
    end
  end
end
