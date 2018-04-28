class MainController < ApplicationController
    def index
        @msg = 'メインページ'
        render 'main/main'
    end
end
