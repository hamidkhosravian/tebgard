class DeviceService
  def initialize(params, request)
    @params = params
    @request = request
  end

  def create_device_token(user)
    user_agent = UserAgent.parse @request.user_agent
    device_uid = @params.try(:[], 'device').try(:[], 'uid') || @request.session.id
    device_name = @params.try(:[], 'device').try(:[], 'name') || user_agent.browser

    device = user.devices.find_by(device_name: "#{device_name}*****#{device_uid}")
    if device
      create_token(device)
    else
      create_device(user)
    end
  end

  private

  def create_device(user)
    device = user.devices.new
    user_agent = UserAgent.parse @request.user_agent
    device_uid = @params.try(:[], 'device').try(:[], 'uid') || @request.session.id
    device_name = @params.try(:[], 'device').try(:[], 'name') || user_agent.browser

    if user_agent.first.comment.to_s.downcase.include? 'android'
      device.device_os = 0
    elsif user_agent.first.comment.to_s.downcase.include? 'ios'
      device.device_os = 1
    elsif user_agent.first.comment.to_s.downcase.include? 'windows'
      device.device_os = 2
    elsif user_agent.first.comment.to_s.downcase.include? 'linux'
      device.device_os = 3
    elsif user_agent.first.comment.to_s.downcase.include? 'os' || 'macintosh'
      device.device_os = 4
    end

    device.device_name = "#{device_name}*****#{device_uid}"
    device.device_last_ip = @request.remote_ip
    device.device_current_ip = @request.remote_ip
    device.save!

    create_token(device)
  end

  def create_token(device)
    device.device_last_ip = device.device_current_ip
    device.device_current_ip = @request.remote_ip
    device.updated_at = Time.now

    device.invalidate_auth_token
    device.generate_auth_token
    device.update_tracked_fields(@request.env)
    device.save!
    device
  end
end
