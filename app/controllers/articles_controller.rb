class ArticlesController < ApplicationController
  before_action do validate_user(current_user) 
    
  end

  def index
    #validate_user(current_user)
    @articles = Article.all

    respond_to do |format|
      format.html
      format.csv { send_data @articles.to_csv}
    end 
  end

  def show
    #validate_user(current_user)
    @article = Article.find(params[:id])
  end

  def new
    #validate_user(current_user)
    @article = Article.new
  end

  def edit
    #validate_user(current_user)
    @article = Article.find(params[:id])
  end  

  def create
    # Der folgende Teil wirft eine Fehlermeldung
    # Richtig is es nur so wie darunter
    # @article = Article.new(params[:article])
    
    # Auch so ist es nicht ganz korrekt, wenn auch richtig
    #@article = Article.new(params.require(:article).permit(:title, :text))
    
    #validate_user(current_user)
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    #validate_user(current_user)
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    #validate_user(current_user)
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end
     
  private
    def article_params
      params.require(:article).permit(:title, :text, :file)
    end
  
    def validate_user(user)
      if user.nil?
        redirect_to login_path
        return
      end
    end
end