module Api
  module V1
    class RelationshipController < ApiController
      before_action :authenticate_user_from_token!

      def followers
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        followers = wall.followers.order("created_at DESC").page(params[:page]).per(params[:limit])
        render json: {response: followers, status: 200}, status: 200
      end

      def following
        param! :page, Integer, default: 1
        param! :limit, Integer, default: 10
        following = wall.following.order("created_at DESC").page(params[:page]).per(params[:limit])
        render json: {response: following, status: 200}, status: 200
      end

      def create
        dr_wall = Wall.find_by(uuid: params[:uid])
        wall.follow(dr_wall.id) unless wall.uuid.eql?(params[:uid].to_i)
        render json: {response: "user followed", status: 200}, status: 200
      end

      def destroy
        relationship = Relationship.find_by(follower_id: wall.id)
        if relationship
          dr_wall = relationship.followed
          wall.unfollow(dr_wall.id)
        end
        render json: {response: "user unfollowed", status: 204}, status: 204
      end
    end
  end
end
