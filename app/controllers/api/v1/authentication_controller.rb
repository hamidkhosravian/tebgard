module Api
  module V1
    class AuthenticationController < ApiController
      def signin
        @user = UserService.new(params).register
        render @user, status: :created
      end

      def logout
        logout_user!
      end

      def refresh_token
        param! :refresh_token, String, blank: false, required: true

        @user = refresh_user!(params[:refresh_token], request)
        render json: @user
      end
    end
  end
end
