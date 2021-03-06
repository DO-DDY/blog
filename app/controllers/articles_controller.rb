class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    def new 
        @article = Article.new
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = "Article was sucessfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end 
    end

    def edit
    end

    def show  
    end

    def update
        if @article.update(article_params)
            flash[:success] = "article was updated"
            redirect_to articles_path(@article)
        else
            flash[:success] = "article was not updated"
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        flash[:success] = "article has been destroyed"
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
