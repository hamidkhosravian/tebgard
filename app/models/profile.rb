class Profile < ApplicationRecord
  belongs_to :user
  has_one    :wall

  has_attached_file :avatar, styles: { thumbnail: "100x100>", medium: "400x400>", large: "700x700>" }, url: "/Users/:user_id-:username/Profile/Avatar/:filename"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  validates_uniqueness_of :username
  enum gender: [ :male, :female ]
  enum role: [ :visitor, :seller ]

  private
    Paperclip.interpolates :name do |file, style|
      "#{file.instance.name}"
    end

    Paperclip.interpolates :user_id do |file, style|
      "#{file.instance.user.id}"
    end

    Paperclip.interpolates :user_email do |file, style|
      "#{file.instance.user.username}"
    end
end
