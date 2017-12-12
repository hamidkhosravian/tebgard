module Api
  module V1
    class WorkingHoursController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office

      def index
        working_hours = @office.open_days
        authorize working_hours
        render json: {response: @working_hours, status: 200}, status: 200
      end

      def create
        param! :day, String, required: true, blank: false
        b.param! :hours, Hash, required: true do |a|
          param! :start_time, String, required: true, blank: false
          param! :close_time, String, required: true, blank: false
        end

        binding.pry
        hours = []
        params[:hours].each do |h|
          hours << {open_time: h[:open_time], close_time: h[:close_time]}
        end

        working_hour = @office.open_days.new(day: params[:day], open_hours_attributes: hours)
        authorize working_hour
        working_hour.save!

        render json: {response: working_hour, status: 200}, status: 200
      end

      def update
      end

      def destroy
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
        end
    end
  end
end
