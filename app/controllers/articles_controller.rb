class ArticlesController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update, :show]

  def index
    initialize_search
    handle_search_name
    handle_filters
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

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.all
  end

  def pdf_download
    @articles = current_user.articles.all
    
    respond_to do |format|
      format.pdf do
        pdf = ExportPdf.new(@articles, current_user)
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :image, :category_id)
  end

  def initialize_search
    params[:filter_option] = nil if params[:filter_option] == ""
     if session[:filter_option] != params[:filter_option]
        session[:filter_option] = params[:filter_option]
     end
  end

  def handle_search_name
    session[:search_name] = params[:search_name]
    if session[:search_name]
      @article = Article.where("title LIKE ?", "%#{session[:search_name]}%")
    else
      @article = Article.all
    end
  end

  def handle_filters
    if session[:filter_option] 
      @article = Article.where(category_id: session[:filter_option])
    end
  end
  
end
