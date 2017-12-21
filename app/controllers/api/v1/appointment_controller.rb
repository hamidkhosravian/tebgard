module Api
  module V1
    class AppointmentController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office
      def index
      end

      def create
      end

      def update
      end

      def destroy
      end

      def active_appointment
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
