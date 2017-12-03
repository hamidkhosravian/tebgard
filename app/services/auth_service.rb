require "auth_token_service"

# authentication Service
# use JWT
class AuthService
  attr_reader :request
  attr_reader :auth_token

  # constructor of class
  # @param request [Request]
  def initialize(request)
    @request = request
    @auth_token = request.headers["Authorization"]
  end

  # check user token
  def authenticate_user!
    raise AuthError unless valid_to_proceed?
    @current_user = ::Device.find(decoded_auth_token[:device_id]).user
    @current_user
  end

  # destory user token
  def destroy_session!
    raise AuthError unless valid_to_logout?
    decoded_auth_token[:device_id]
  end

  private

  # check user has access or not to logout
  def valid_to_logout?
    http_auth_token && decoded_auth_token && decoded_auth_token[:device_id] && valid_token?
  end

  # check user has access or not for a request
  def valid_to_proceed?
    http_auth_token && decoded_auth_token && decoded_auth_token[:device_id] && valid_token? # && valid_device?
  end

  # check user token and validation of token
  def valid_token?
    ::AuthToken.where(tokenable_id: decoded_auth_token[:device_id], tokenable_type: :Device).newer.first.token == http_auth_token
  end

  def valid_device?
    user_agent = UserAgent.parse @request.user_agent
    if user_agent.first.comment.to_s.downcase.include? "android"
      device_os = 0
    elsif user_agent.first.comment.to_s.downcase.include? "ios"
      device_os = 1
    elsif user_agent.first.comment.to_s.downcase.include? "windows"
      device_os = 2
    elsif user_agent.first.comment.to_s.downcase.include? "linux"
      device_os = 3
    elsif user_agent.first.comment.to_s.downcase.include? "os" || "macintosh"
      device_os = 4
    end

    device_uid = @params.try(:[], "device").try(:[], "uid") || @request.session.id
    device_name = @params.try(:[], "device").try(:[], "name") || user_agent.browser
    device_name = "#{device_name}*****#{device_uid}"

    decoded_auth_token[:device_os] == device_os && decoded_auth_token[:device_name] == device_name
  end

  # decode the token and return the response
  def decoded_auth_token
    @decoded_auth_token ||= ::AuthTokenService.decode(http_auth_token)
  end

  # get token from Authorization in header
  def http_auth_token
    if auth_token.present?
      if auth_token.to_s.split(" ").first.casecmp("bearer").zero?
        @http_auth_token ||= auth_token.split(" ").last
      elsif Rails.env.development? && auth_token.split(" ").first.casecmp("basic").zero?
        @http_auth_token = Base64.decode64(auth_token.split(" ").last)
      end
    end
  end
end
