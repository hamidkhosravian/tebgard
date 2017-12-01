# authentication common functions
module Auth
  # return first association auth_token model
  def token
    self.auth_tokens.newer.first
  end

  # generate and asign token and refresh token to Model with AuthToken Model
  # Class.generate_auth_token '127.0.0.1'
  # Class.auth_tokens.token # => eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJhdXRoX3R
  # Class.auth_tokens.refresh_token # => ab9239a532e59a164e1e9a319d5c
  # ttl = ENV['AUTH_TOKEN_TTL'].to_i
  def generate_auth_token(ttl = ENV["AUTH_TOKEN_TTL"], refresh_ttl = ENV["AUTH_TOKEN_TTL"])
    ttl = ttl.to_i.hour.from_now
    refresh_ttl = refresh_ttl.to_i.hour.from_now

    auth_token = self.auth_tokens.build

    auth_token.token = ::AuthTokenService.encode({ device_id: self.id, device_os: self.device_os, device_name: self.device_name }, ttl)
    auth_token.token_expires_at = ttl

    auth_token.refresh_token = generate_refresh_token
    auth_token.refresh_token_expires_at = refresh_ttl
  end

  # invalidate current token and refresh token in 1 minute
  def invalidate_auth_token
    exp = Time.now
    return false if self.auth_tokens.empty?
    auth_token = self.token

    auth_token.token = ::AuthTokenService.encode({ device_id: self.id }, exp)
    auth_token.token_expires_at = 1.days.ago
    auth_token.refresh_token_expires_at = 1.days.ago
    auth_token.save!
  end

  # update last sign in and last ip
  # Params:
  # +env+: request header
  def update_tracked_fields(env)
    new_current = Time.now.utc
    self.user.last_sign_in_at = self.user.current_sign_in_at || new_current
    self.user.current_sign_in_at = new_current

    new_current = env["REMOTE_ADDR"]
    self.user.last_sign_in_ip = self.user.current_sign_in_ip || new_current
    self.user.current_sign_in_ip = new_current

    self.user.sign_in_count = self.user.sign_in_count.to_i + 1
    self.user.save!
  end

    private
      # generate random string for refresh token
      def generate_refresh_token
        Digest::MD5.hexdigest(Time.now.to_s) + SecureRandom.hex
      end
end
