module Api
  module V1
    class RelationshipController < ApiController
      before_action :authenticate_user_from_token!

      def create
        dr_wall = Wall.find_by(uuid: params[:uid])
        unless wall.uuid.eql?(params[:uid].to_i)
          wall.follow(dr_wall.id)
          render json: {response: "user followed", status: 200}, status: 200
        end
      end

      def destroy
        relationship = Relationship.find_by(follower_id: wall.id)
        if relationship
          dr_wall = relationship.followed
          wall.unfollow(dr_wall.id)
          render json: {response: "user unfollowed", status: 204}, status: 204
        end
      end
    end
  end
end
