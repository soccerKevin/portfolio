class Article < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  def published?
    published
  end
end
