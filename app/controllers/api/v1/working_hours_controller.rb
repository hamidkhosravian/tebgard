module Api
  module V1
    class WorkingHoursController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office

      def index
        working_days = @office.open_days
        authorize working_days
        render json: {response: working_days, status: 200}, status: 200
      end

      def create
        param! :day, String, required: true, blank: false
        b.param! :hours, Hash, required: true do |a|
          param! :start_time, String, required: true, blank: false
          param! :close_time, String, required: true, blank: false
        end

        hours = []
        params[:hours].each do |h|
          hours << {open_time: h[:open_time], close_time: h[:close_time]}
        end

        working_hours = @office.open_days.new(day: params[:day], open_hours_attributes: hours)
        authorize working_hours
        working_hours.save!

        render json: {response: working_hours, status: 200}, status: 200
      end

      def update
        param! :id, Integer, required: true, blank: false
        param! :day, Integer, required: true, blank: false

        working_hour = @office.open_days.find(id: params[:day_id]).open_hours.find(id: params[:id])
        authorize working_hour
        working_hour.start_time = params[:start_time] if params[:start_time]
        working_hour.close_time = params[:close_time] if params[:close_time]
        working_hour.save!

        render json: {response: working_hour, status: 200}, status: 200
      end

      def destroy_day
        param! :id, Integer, required: true, blank: false
        working_day = @office.open_days.find(id: params[:id])
        authorize working_day
        working_day.destroy!
        render status: 204
      end

      def destroy_hour
        param! :id, Integer, required: true, blank: false
        param! :day, Integer, required: true, blank: false

        working_hour = @office.open_days.find(id: params[:day_id]).open_hours.find(id: params[:id])
        authorize working_hour
        working_hour.destroy!
        render status: 204
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
