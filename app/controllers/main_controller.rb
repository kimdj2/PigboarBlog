class MainController < ApplicationController
    #タグ情報を取得する。
    before_action :setTagAndCategory
    #レスポンスタイプ指定
    respond_to :rss, :html
    #メイン画面表示
    def index
        #いいね数で検索し、人気順データを取得する。（メイン表示用5件）
        @boards_like = Board.all.order("likes_count DESC").order("view DESC").limit(5)
        render 'main/main'
    end

    #rss feed取得
    def feed
        #最新のPost情報5件を取得する。
        @boards = Board.all.order(created_at:"DESC").limit(5)
        respond_to do |format|
            #rss形式でデータを返す。
            format.rss { render :layout => false }
        end      
    end
end
