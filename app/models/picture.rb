class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { thumbnail: "500x500>", medium: "800x800>", large: "1200x1200>" },
                    path: ':rails_root/public/:imageable/:imageable_uuid/:style-:hash.:extension',
                    hash_secret: Rails.application.secrets.secret_key_base,
                    url: '/:imageable/:imageable_uuid/:style-:hash.:extension'

  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 5.megabytes

  private
    Paperclip.interpolates :imageable do |file, style|
      "#{file.instance.imageable.class.to_s}"
    end


    Paperclip.interpolates :imageable_uuid do |file, style|
      if file.instance.imageable.class == Office
        uuid = file.instance.imageable.wall.uuid
        "#{uuid}"
      else
        "#{file.instance.imageable.id}"
      end
    end
end
