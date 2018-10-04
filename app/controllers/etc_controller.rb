class EtcController < ApplicationController
    #aboutページ表示
    def about
        #タイトル指定
        @title = "About Us"
        #aboutページへ遷移
        render 'about/about.html.erb'
    end
end
