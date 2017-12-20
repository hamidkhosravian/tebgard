module Api
  module V1
    class OfficeController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_office, except: [:index, :create]

      def index
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        offices = wall.offices.order("created_at DESC").page(params[:page]).per(params[:limit])
        authorize offices
        render json: { response: offices, status: 200 }, status: 200
      end

      def create
        param! :latitude, String, required: true, blank: false
        param! :longitude, String, required: true, blank: false
        param! :address, String, required: true, blank: false
        param! :office_phone_number, String, required: true, blank: false
        param! :description, String, required: true, blank: false

        office = Office.new
        authorize office

        office.wall = current_user.profile.wall
        office.latitude = params[:latitude]
        office.longitude = params[:longitude]
        office.address = params[:address]
        office.office_phone_number = params[:office_phone_number] if TelephoneNumber.parse(params[:office_phone_number]).valid?
        office.description = params[:description]
        office.save!

        render json: { response: office, status: 201 }, status: 201
      end

      def show
        render json: { response: @office, status: 200 }, status: 200
      end

      def update
        @office.latitude = params[:latitude] if params[:latitude]
        @office.longitude = params[:longitude] if params[:longitude]
        @office.address = params[:address] if params[:address]
        @office.office_phone_number = params[:office_phone_number] if params[:office_phone_number] && TelephoneNumber.parse(params[:office_phone_number]).valid?
        @office.description = params[:description] if params[:description]
        @office.save!

        render json: { response: @office, status: 200 }, status: 200
      end

      def upload_file
        paperclip = PaperclipService.new(@office)
        paperclip.upload_image(params[:image]) if params[:image]
        paperclip.upload_multimedia(params[:multimedia]) if params[:multimedia]
        paperclip.upload_document(params[:document]) if params[:document]

        render json: { response: @office, status: 200 }, status: 200
      end

      def destroy
        @office.destroy!
        render status: 204
      end

      def wall_offices
        param! :uid, String, required: true, blank: false
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10

        wall = Wall.find_by(uuid: params[:uid])
        offices = wall.offices.order("created_at DESC").page(params[:page]).per(params[:limit])
        authorize offices

        render json: { response: offices, status: 200 }, status: 200
      end

      def add_office_activities
        @office.office_activity_tag_list = params[:activities]
        @office.save!
        render json: {response: @office.office_activity_tag_list, status: 201 }
      end

      def like
        @office.liked_by current_user.profile
        render json: {response: "like office.", status: 201 }
      end

      def unlike
        @office.unliked_by current_user.profile
        render json: {response: "unlike office.", status: 204}, status: 204
      end

      def offices_find_by_activities
        param! :activities, Array, required: true, blank: false
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10

        offices = Office.tagged_with(params[:activities], any: true).order("created_at DESC").page(params[:page]).per(params[:limit])
        authorize offices

        render json: { response: offices, status: 200 }, status: 200
      end

      private
        def set_office
          param! :uid, String, required: true, blank: false
          @office = Office.find_by(uuid: params[:uid])
          authorize @office
        end
    end
  end
end
