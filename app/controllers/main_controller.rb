class MainController < ApplicationController
    before_action :setTagAndCategory
    def index
        @boards = Board.all.order(created_at:"DESC").limit(6)
        @boards_ino = Board.where("author='イノシシ'").order(created_at:"DESC").limit(6)
        @boards_buta = Board.where("author='豚'").order(created_at:"DESC").limit(6)
        render 'main/main'
    end
end
