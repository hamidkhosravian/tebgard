module Api
  module V1
    class WallController < ApiController
      before_action :authenticate_user_from_token!
      before_action :set_article, except: [:create, :show, :update, :add_skills, :remove_skills]

      def create
        param! :doctor_code, String, required: true, blank: false

        wall = Wall.create!(doctor_code: params[:doctor_code], profile: current_user.profile)
        render json: { response: wall, status: 201 }, status: 201
      end

      def show
        authorize wall
        render json: { response: wall, status: 200 }, status: 200
      end

      def update
        authorize wall
        wall.description = params[:description] if params[:description]
        if params[:doctor_code] && wall.doctor_code != params[:doctor_code]
          wall.doctor_code = params[:doctor_code]
          wall.active = false
          current_user.profile.role = "visitor"
          current_user.profile.save!
        end
        wall.save!

        render json: { response: wall, status: 200 }, status: 200
      end

      def add_skills
        param! :skills, Array, required: true, blank: false

        authorize wall
        wall = current_user.profile.wall
        wall.skill_list << params[:skills]

        wall.save!
        render json: { response: wall.skill_list, status: 201 }, status: 201
      end

      def remove_skills
        param! :skills, Array, required: true, blank: false

        authorize wall
        wall = current_user.profile.wall
        wall.skill_list -= params[:skills]

        wall.save!
        render json: { response: wall.skill_list, status: 200 }, status: 200
      end

      def show_wall
        render json: { response: @wall_with_uuid, status: 200 }, status: 200
      end

      def favorite
        @wall_with_uuid.liked_by current_user.profile

        render json: {response: "add to favorite list", status: 201 }
      end

      def unfavorite
        @wall_with_uuid.unliked_by current_user.profile

        render json: {response: "remove from favorite list.", status: 204}, status: 204
      end

      private
        def set_wall
          param! :uid, String, required: true, blank: false
          @wall_with_uuid = Wall.find_by!(uuid: params[:uid])
        end
    end
  end
end
