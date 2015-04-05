class ArticlePolicy < ApplicationPolicy
  attr_accessor :user, :article

  def initalize(user, article)
    @user = user ? user : NullUser.new
    @article = article
  end

  def index
    # scope.where(:published => true)
    article.published
  end

  def publish?
    @user.editor?
  end

  def edit?
    delete?
  end

  def delete?
    @user.editor? || (record.author == @user && !record.published)
  end

  class Scope < Scope
    def resolve
      if user.editor?
        scope.all
      elsif user.author?
        scope.where(:author => user) + scope.where(:published => true) # or where published?
      else
        scope.where(:published => true)
      end
    end
  end

end
