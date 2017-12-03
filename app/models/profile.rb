class Profile < ApplicationRecord
  belongs_to :user
  has_one    :wall

  has_attached_file :avatar, styles: { thumbnail: '100x100>', medium: '400x400>', large: '700x700>' }, url: '/Users/:user_id-:username/Profile/Avatar/:filename'
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  validates_uniqueness_of :username
  enum gender: %i[male female]
  enum role: %i[visitor seller]

  private

  Paperclip.interpolates :name do |file, _style|
    file.instance.name.to_s
  end

  Paperclip.interpolates :user_id do |file, _style|
    file.instance.user.id.to_s
  end

  Paperclip.interpolates :user_email do |file, _style|
    file.instance.user.username.to_s
  end
end
