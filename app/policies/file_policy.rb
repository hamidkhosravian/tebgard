class FilePolicy < ApplicationPolicy
  def destroy?
    true if check_file
  end

  private
    def file
      record
    end

    def check_file
      case file
      when Multimedium
        multimedia
      when Document
        document
      when Picture
        image
      end
    end

    def multimedia
      file.multimediable.wall == profile.wall
    end

    def document
      file.documentable.wall == profile.wall
    end

    def image
      file.imageable.wall == profile.wall
    end
end
