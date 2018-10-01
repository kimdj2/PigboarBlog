class MainController < ApplicationController
    before_action :setTagAndCategory
    respond_to :rss, :html
    def index
        @boards = Board.all.order(created_at:"DESC").limit(5)
        @boards_like = Board.all.order("likes_count DESC").order("view DESC").limit(5)
        render 'main/main'
    end
    def feed
        @boards = Board.all.order(created_at:"DESC").limit(5)
        respond_to do |format|
            format.rss { render :layout => false }
        end      
    end
end
