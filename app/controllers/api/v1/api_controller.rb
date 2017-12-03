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

      # pagination dictionary for more information
      def pagination_dict(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end
    end
  end
end
