class MainController < ApplicationController
    before_action :setTagAndCategory
    respond_to :rss, :html
    def index
        @boards = Board.all.order(created_at:"DESC").limit(6)
        @boards_ino = Board.where("author='イノシシ'").order(created_at:"DESC").limit(6)
        @boards_buta = Board.where("author='豚'").order(created_at:"DESC").limit(6)
        render 'main/main'
    end
    def feed
        @boards = Board.all.order(created_at:"DESC").limit(6)
        respond_to do |format|
            format.atom
            format.rss { render :layout => false }
        end      
    end
end
