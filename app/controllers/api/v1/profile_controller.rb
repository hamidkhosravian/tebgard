module Api
  module V1
    class ProfileController < ApiController
      before_action :authenticate_user_from_token!

      def update
        profile = current_user.profile
        profile.first_name = params[:first_name] if params[:first_name]
        profile.last_name = params[:last_name] if params[:last_name]
        profile.description = params[:description] if params[:description]
        profile.phone = params[:phone] if !current_user.phone && params[:phone] && TelephoneNumber.parse(params[:phone]).valid?
        profile.birthdate = params[:birthdate] if params[:birthdate]
        profile.email = params[:email] if params[:email]
        profile.gender = params[:gender] if params[:gender]
        profile.username = params[:username] if params[:username]

        profile.save!
        render json: { response: current_user.profile, status: 200 }
      end

      def upload_avatar
        current_user.profile.avatar = params[:avatar]
        current_user.profile.save!
        render json: { response: current_user.profile, status: 201 }, status: 201
      end

      def show
        render json: { response: current_user.profile, status: 200 }
      end

      def show_profile
        param! :uid, String, required: true, blank: false
        profile = Profile.find_by!(uuid: params[:uid])
        render json: { response: profile, status: 200 }
      end
    end
  end
end
