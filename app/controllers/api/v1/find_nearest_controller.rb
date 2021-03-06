module Api
  module V1
    class FindNearestController < ApiController
      before_action :authenticate_user_from_token!

      def office
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :distance, Integer, default: 3, max: 20, min: 2
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false

        offices = Office.near([params[:latitude],params[:longitude]],params[:distance], units: :km).order("created_at DESC").page(params[:page]).per(params[:limit])

        render json: offices, adapter: :json, meta: pagination_dict(offices)
      end

      def offices_by_skills
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :distance, Integer, default: 5, max: 20, min: 3
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false
        param! :skills, Array, required: true, blank: false

        offices = Office.where(wall: Wall.tagged_with(params[:skills], any: true).except(:select)).near([params[:latitude],params[:longitude]],params[:distance], units: :km).order("created_at DESC").page(params[:page]).per(params[:limit])

        render json: offices, adapter: :json, meta: pagination_dict(offices)
      end

      def offices_by_activities
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        param! :distance, Integer, default: 5, max: 20, min: 3
        param! :latitude, Float, required: true, blank: false
        param! :longitude, Float, required: true, blank: false
        param! :activities, Array, required: true, blank: false

        offices = Office.tagged_with(params[:activities], any: true).near([params[:latitude],params[:longitude]],params[:distance], units: :km).order("created_at DESC").page(params[:page]).per(params[:limit])
        authorize offices

        render json: { response: offices, status: 200 }, status: 200
      end
    end
  end
end
