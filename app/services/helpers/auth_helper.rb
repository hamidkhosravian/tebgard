require 'auth_service'

module Helpers::AuthHelper
  # generate a refresh token for user's device
  def refresh_user!(token, request)
    auth_token = AuthToken.find_by(refresh_token: token)
    # refresh token expires
    raise AuthError, I18n.t('messages.authentication.login.refresh_token') if auth_token.nil? || auth_token.refresh_token_expires_at.nil? || auth_token.refresh_token_expires_at.to_date <= Time.now

    device = auth_token.tokenable
    create_token(device, request)
  end

  # invalidate all session
  def logout_user!
    device_id = ::AuthService.new(request).destroy_session!
    device = ::Device.includes(:auth_tokens).find_by_id(device_id)
    device.invalidate_auth_token
  end

  def authorize!(*args)
    message, code = extract_custom_http_message_code(*args)
    ability = ::Ability.new(current_user)
    ability.authorize!(*args)
  rescue CanCan::AccessDenied => ex
    Helpers::ErrorHelper.error!(message, code)
  end

  # authenticate current request
  def authenticate!
    @current_user = ::AuthService.new(request).authenticate_user!
  end

  # return current authenticated user
  def current_user
    @current_user
  end

  def extract_custom_http_message_code(*args)
    custom_message = args[2][:message] if args[2].present? && args[2][:message].present?
    custom_code = args[2][:code] if args[2].present? && args[2][:code].present?
    message = custom_message ||= I18n.t('messages.http._403')
    code = custom_code ||= 403
    [message, code]
  end

  # create new token for user
  # this method will invalidate last token
  def create_token(device, request)
    device.device_last_ip = device.device_current_ip
    device.device_current_ip = request.remote_ip
    device.updated_at = Time.now

    device.invalidate_auth_token
    device.generate_auth_token
    device.update_tracked_fields(request.env)
    device.save!

    token = {
      token: device.token.token,
      token_expires_at: device.token.token_expires_at,
      refresh_token: device.token.refresh_token,
      refresh_token_expires_at: device.token.refresh_token_expires_at
    }.to_json
  end
end
