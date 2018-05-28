class MainController < ApplicationController
    before_action :setTagAndCategory
    def index
        @boards = Board.all.order(created_at:"DESC").limit(5)
        render 'main/main'
    end
end
