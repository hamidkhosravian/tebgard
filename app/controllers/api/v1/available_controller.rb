module Api
  module V1
    class AvailableController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office


      def office_available_index
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10

        availables = @office.availables.order("created_at DESC").page(params[:page]).per(params[:limit])
        authorize availables
        render json: { response: availables, status: 200 }, status: 200, adapter: :json, meta: pagination_dict(availables)
      end

      def office_available
        param! :date, Date, required: true, blank: false
        param! :start_time, Time, required: true, blank: false
        param! :end_time, Time, required: true, blank: false
        param! :description, String, required: true, blank: false
        param! :status, :boolean, required: true, blank: false

        check_working_time(params)

        activable = @office.availables.new
        authorize activable

        activable.date = params[:date]
        activable.start_time = params[:start_time]
        activable.end_time = params[:end_time]
        activable.description = params[:description]
        activable.status = params[:status]
        activable.save!

        render json: { response: activable, status: 200 }, status: 200
      end

      def office_update
        param! :id, Integer, required: true, blank: false
        param! :date, Date, required: false, blank: false
        param! :start_time, Time, required: false, blank: false
        param! :end_time, Time, required: false, blank: false
        param! :description, String, required: false, blank: false
        param! :status, :boolean, required: true, blank: false

        check_working_time(params)

        available = Available.find_by(id: params[:id])
        authorize available

        available.date = params[:date] if params[:date]
        available.start_time = params[:start_time] if params[:start_time]
        available.end_time = params[:end_time] if params[:end_time]
        available.description = params[:description] if params[:description]
        activable.status = params[:status] if params[:status]
        available.save!

        render json: { response: available, status: 200 }, status: 200
      end

      def destroy
        param! :id, Integer, required: true, blank: false

        available = Available.find_by(id: params[:id])
        authorize available
        available.destroy!
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end

        def check_working_time(params)
          @office.working_hours

          start_time = Time.parse("#{params[:date]} #{params[:start_time].strftime("%I:%M")}").in_working_hours?
          end_date = Time.parse("#{params[:date]} #{params[:end_time].strftime("%I:%M")}").in_working_hours?

          if params[:status]
            raise BadRequestError, I18n.t("messages.date.is_working_day") if params[:date].working_day?
            raise BadRequestError, I18n.t("messages.date.is_working_hour") if start_time && end_date
          else
            raise BadRequestError, I18n.t("messages.date.not_working_day") unless params[:date].working_day?
            raise BadRequestError, I18n.t("messages.date.not_working_hour") unless start_time && end_date
          end
        end
    end
  end
end
