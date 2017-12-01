class FirebaseService
  def initialize(params, request)
    @params = params
    @request = request
  end

  def firebase_verification
    base_url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/"
    conn = Faraday.new base_url
    response = conn.post do |req|
      req.url "getAccountInfo?key=#{ENV['FIREBASE_API_KEY']}"
      req.body = {idToken: @params["firebase_token"]}.to_json
      req.headers["Content-Type"] = "application/json"
    end

    raise AuthError unless response.status == 200
    JSON.parse(response.body)
  end
end
