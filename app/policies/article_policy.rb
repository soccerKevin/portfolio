class ArticlePolicy < ApplicationPolicy
  attr_accessor :user, :article

  def initalize(user, article)
    @user = user
    @article = article
  end

  def publish?
    @user.editor?
  end

  def delete?
    @user.editor? || (record.author == @user && !record.published)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

end
