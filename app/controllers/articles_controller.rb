class ArticlesController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]

  def index
    @article = Article.search(params[:q].present? ? params[:q] : '*').records.order("created_at ASC")
  end

  def new
    @article = Article.new
  end

  def create 
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to new_article_path, flash: { success: "Article created succesfully create more !"}
    else
      render "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to root_path, flash: { success: "article updated successfully!" }
    else
      render "edit"
    end
  end

  def like_reaction
    @article = Article.find(params[:id])
    
    @reaction = current_user.reactions.find_by(article: @article.id)
    if @article.update(article_params)
      if @reaction.react == true
        if @reaction.update(react: nil)
          redirect_to root_path, flash: { success: "you removed your reaction from an article!" }
        end
      elsif @reaction.react == false
        if @reaction.update(react: true)
          redirect_to root_path, flash: { success: "changed reaction! liked an article!" }
        end
      else
        if @reaction.update(react: true)
          redirect_to root_path, flash: { success: "you liked an article!" }
        end
      end
    else
      render "edit"
    end
  end
   
    def dislike_reaction
      @article = Article.find(params[:id])
      
      @reaction = current_user.reactions.find_by(article: @article.id)
      if @article.update(article_params)
        if @reaction.react == false
          if @reaction.update(react: nil)
            redirect_to root_path, flash: { success: "you removed your reaction from an article!" }
          end
        elsif @reaction.react == true
          if @reaction.update(react: false)
            redirect_to root_path, flash: { success: "changed reaction! disliked an article!" }
          end
        else
          if @reaction.update(react: false)
            redirect_to root_path, flash: { success: "you disiked an article!" }
          end
        end
      else
        render "edit"
      end
     end

  private

  def article_params
    params.require(:article).permit(:title, :description, :image, :category_id)
  end
end
