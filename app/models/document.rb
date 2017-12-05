class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true

  has_attached_file :attachment,
                            path: ":rails_root/public/:documentable/:documentable_uuid/:date/documents/:filename-:hash.:extension",
                            hash_secret: Rails.application.secrets.secret_key_base,
                            url: "/:documentable/:documentable_uuid/:filename-:hash.:extension"

  validates_attachment_content_type :attachment, content_type: ["application/pdf","application/vnd.ms-excel",
                                                           "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                                           "application/msword",
                                                           "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                           "text/plain"]

  validates_with AttachmentSizeValidator, attributes: :attachment, less_than: 20.megabytes


  private

  Paperclip.interpolates :date do |file, _style|
    DateTime.now.to_date.to_s
  end

  Paperclip.interpolates :documentable do |file, _style|
    file.instance.documentable.class.to_s
  end

  Paperclip.interpolates :documentable_uuid do |file, _style|
    file.instance.documentable.uuid.to_s
  end
end
