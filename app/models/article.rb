class Article < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :comments, foreign_key: "article_id"

  def published?
    published
  end
end
