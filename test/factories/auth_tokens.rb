FactoryBot.define do
  factory :auth_token do
    token "MyString"
    refresh_token "MyString"
    token_expires_at "2017-11-22 16:42:52"
    refresh_token_expires_at "2017-11-22 16:42:52"
    tokenable nil
  end
end
