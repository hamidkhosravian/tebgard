class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    user_service = UserService.new(params)
    @user = user_service.find_for_oauth(request, auth, current_user)
    render json: @user
  end

  def twitter
    auth = request.env["omniauth.auth"]
    user_service = UserService.new(params)
    @user = user_service.find_for_oauth(request, auth, current_user)
    render json: @user
  end

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user_service = UserService.new(params)
    @user = user_service.find_for_oauth(request, auth, current_user)
    render json: @user
  end

  def failure
    raise AuthError
  end
end
