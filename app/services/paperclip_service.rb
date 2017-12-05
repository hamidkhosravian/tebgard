class PaperclipService
  def initialize(object)
    @object = object
  end

  def upload_image(image)
    picture = Picture.new
    picture.image = image
    picture.imageable = @object
    picture.save!
  end

  def upload_multimedia(multimedia)
    multimedium = Multimedium.new
    multimedium.attachment = multimedia
    multimedium.multimediable = @object
    multimedium.save!
  end

  def upload_document(doc)
    document = Document.new
    document.attachment = doc
    document.documentable = @object
    document.save!
  end
end
