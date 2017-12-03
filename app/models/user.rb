class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]

  has_one  :profile
  has_many :devices

  after_create :create_profile

  private

  def create_profile
    username = phone || email
    Profile.create!(user: self, username: username, phone: phone, role: 0)
  end
end
