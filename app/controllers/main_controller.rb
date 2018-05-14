class MainController < ApplicationController
    def index
        @boards = Board.all.order(created_at:"DESC").limit(10)
        render 'main/main'
    end
end
