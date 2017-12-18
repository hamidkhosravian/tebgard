module Api
  module V1
    class ActivationController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office

      def office_activation
        param! :id, Integer, required: true, blank: false

        activable = @office.activations.find_by!(id: params[:id])
        activable.destroy

        render status 204
      end

      def office_deactivation
        param! :date, Date, required: true, blank: false
        param! :start_time, Time, required: true, blank: false
        param! :end_time, Time, required: true, blank: false
        param! :description, String, required: true, blank: false

        @office.working_hours

        raise BadRequestError, I18n.t("messages.date.not_day_working") unless params[:date].working_day?
        raise BadRequestError, I18n.t("messages.date.not_hour_working") unless params[:start_time].in_working_hours? && params[:end_date].in_working_hours?

        activable = @office.activations.new
        activable.date = params[:date]
        activable.start_time = params[:start_time]
        activable.end_time = params[:end_time]
        activable.description = params[:description]
        activable.save!

        render json: { response: activable, status: 200 }, status: 200
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
