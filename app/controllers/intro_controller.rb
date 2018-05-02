class IntroController < ApplicationController
    def index
        @msg = 'メインページ'
        render 'intro'
    end
end
