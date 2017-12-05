class Multimedium < ApplicationRecord
  belongs_to :multimediable, polymorphic: true

  has_attached_file :attachment,
                            path: ":rails_root/public/:multimediable/:multimediable_uuid/:date/multimedias/:filename-:hash.:extension",
                            hash_secret: Rails.application.secrets.secret_key_base,
                            url: "/:multimediable/:multimediable_uuid/:filename-:hash.:extension"

  validates_attachment_content_type :attachment, content_type: [/\Aaudio\/.*\Z/, /\Avideo\/.*\Z/]

  validates_with AttachmentSizeValidator, attributes: :attachment, less_than: 128.megabytes


  private

  Paperclip.interpolates :date do |file, _style|
    DateTime.now.to_date.to_s
  end

  Paperclip.interpolates :multimediable do |file, _style|
    file.instance.multimediable.class.to_s
  end

  Paperclip.interpolates :multimediable_uuid do |file, _style|
    file.instance.multimediable.uuid.to_s
  end
end
