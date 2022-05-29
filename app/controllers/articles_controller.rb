class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to article_path(@article), notice: 'saved'
        else
            flash.now[:error] = 'Save failed'
            render :new
        end
    end

    def edit
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: 'updated'
        else
            flash.now[:error] = 'Update failed'
            render :edit
        end
    end

    def destroy
        article = current_user.articles.find(params[:id])
        article.destroy!
        redirect_to root_path, notice: 'Successfully removed'
    end

    private
    def article_params
        params.require(:article).permit(:title, :content)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
