module Api
  module V1
    class ApiController < ApplicationController
      include Helpers::AuthHelper

      private

      # before anything check user authentication
      def authenticate_user_from_token!
        authenticate = authenticate!
        render json: { response: authenticate[:response] }, status: :unauthorized if authenticate[:response]
        authenticate
      end
    end
  end
end
