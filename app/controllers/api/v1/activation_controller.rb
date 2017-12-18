module Api
  module V1
    class ActivationController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office

      def office_activation
      end

      def office_deactivation
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
