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
        param! :hours, Array, required: true do |a|
          a.param! :open_time, String, required: true, blank: false
          a.param! :close_time, String, required: true, blank: false
        end

        hours = []
        params[:hours].each do |hour|
          hours << {open_time: hour["open_time"], close_time: hour["close_time"]}
        end

        working_days = @office.open_days.new(day: params[:day], open_hours_attributes: hours)
        authorize working_days
        working_days.save!

        render json: {response: working_days, status: 200}, status: 200
      end

      def update
        param! :id, Integer, required: true, blank: false
        param! :day, String, required: true, blank: false

        working_hour = @office.open_days.find_by(day: params[:day]).open_hours.find_by(id: params[:id])
        authorize working_hour
        working_hour.open_time  = params[:open_time]  if params[:open_time]
        working_hour.close_time = params[:close_time] if params[:close_time]
        working_hour.save!

        render json: {response: working_hour, status: 200}, status: 200
      end

      def destroy_day
        param! :day, String, required: true, blank: false
        working_day = @office.open_days.find_by(day: params[:day])
        authorize working_day
        working_day.destroy!
        render json: {}, status: 204
      end

      def destroy_hour
        param! :id, Integer, required: true, blank: false
        param! :day, String, required: true, blank: false

        working_hour = @office.open_days.find_by(day: params[:day]).open_hours.find_by(id: params[:id])
        authorize working_hour
        working_hour.destroy!
        render json: {}, status: 204
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
