# user Service
# user registeration or other staff
class UserService
  # constructor of class
  def initialize(params)
    @params = params
  end

  # register user
  # if every thing was fine user saved in database
  # if somthing was wrong return error
  def register(request)
    firebase = FirebaseService.new(@params, request).firebase_verification
    phone_number = firebase.try(:[], "users").try(:[], 0).try(:[], "phoneNumber")
    local_id = firebase.try(:[], "users").try(:[], 0).try(:[], "localId")
    user = User.create!(email: "#{local_id}@firbase.com", password: Devise.friendly_token[0, 20], phone: phone_number)
    create_token(user, request)
  end

  def find_for_oauth(request, auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      if user.nil?
        email_provider = auth.info.email || "#{auth.info.name.delete(' ')}-#{auth.uid}@#{auth.provider}.com"
        user = User.new(
          email: email ? email : email_provider,
          password: Devise.friendly_token[0, 20]
        )
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    create_token(user, request)
  end

  private

  def create_token(user, request)
    device_service = DeviceService.new(@params, request)
    device = device_service.create_device_token(user)
    token = {
      token: device.token.token,
      token_expires_at: device.token.token_expires_at,
      refresh_token: device.token.refresh_token,
      refresh_token_expires_at: device.token.refresh_token_expires_at
    }.to_json
  end
end
