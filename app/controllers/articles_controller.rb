class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end 
    
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to article_path(@article), notice: 'saved'
        else
            flash.now[:error] = 'Save failed'
            render :new
        end    
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: 'updated'
        else
            flash.now[:error] = 'Update failed'
            render :edit
        end
    end

    def destroy
        article = Article.find(params[:id])
        article.destroy!
        redirect_to root_path, notice: 'Successfully removed'
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :content)
    end
end