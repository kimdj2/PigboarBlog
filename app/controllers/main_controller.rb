class MainController < ApplicationController
    def index
        @boards = Board.all.order(created_at:"DESC").limit(10)
        @tags = ActsAsTaggableOn::Tag.all
        render 'main/main'
    end
end
