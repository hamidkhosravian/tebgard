module Api
  module V1
    class OfficeController < ApiController
      before_action :authenticate_user_from_token!

      def create
        param! :latitude, String, required: true, blank: false
        param! :longitude, String, required: true, blank: false
        param! :address, String, required: true, blank: false
        param! :office_phone_number, String, required: true, blank: false
        param! :description, String, required: true, blank: false

        office = Office.new
        office.wall = current_user.profile.wall
        office.latitude = params[:latitude]
        office.longitude = params[:longitude]
        office.address = params[:address]
        office.office_phone_number = params[:office_phone_number] if TelephoneNumber.parse(params[:office_phone_number]).valid?
        office.description = params[:description]
        office.save!

        render json: {response: office, status: 201}, status: 201
      end

      def show
        param! :uid, String, required: true, blank: false

        office = Office.find_by(uuid: params[:uid])

        render json: {response: office, status: 200}, status: 200
      end

      def update
        param! :uid, String, required: true, blank: false

        office = Office.find_by(uuid: params[:uid])
        office.latitude = params[:latitude] if params[:latitude]
        office.longitude = params[:longitude] if params[:longitude]
        office.address = params[:address] if params[:address]
        office.office_phone_number = params[:office_phone_number] if params[:office_phone_number] && TelephoneNumber.parse(params[:office_phone_number]).valid?
        office.description = params[:description] if params[:description]
        office.save!

        render json: {response: office, status: 200}, status: 200
      end

      def upload_image
        param! :uid, String, required: true, blank: false

        office = Office.find_by(uuid: params[:uid])
        picture = Picture.new
        picture.image = params[:image]
        picture.imageable = office
        picture.save!

        render json: {response: office.pictures , status: 201}, status: 201
      end

      def destroy
        param! :uid, String, required: true, blank: false

        office = Office.find_by(uuid: params[:uid])
        office.destroy!

        render status: 204
      end
    end
  end
end
