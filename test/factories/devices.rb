FactoryBot.define do
  factory :device do
    devise_os 1
    device_name 'MyString'
    device_last_ip ''
    device_current_ip ''
    user nil
  end
end
