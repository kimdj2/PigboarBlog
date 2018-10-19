class MainController < ApplicationController
    #タグ情報を取得する。
    before_action :setTagAndCategory
    #レスポンスタイプ指定
    respond_to :rss, :html
    #メイン画面表示

    PER = 5

    def index
        #いいね数で検索し、人気順データを取得する。（メイン表示用5件）
        @boards_like = Board.page(params[:page]).order(created_at:"DESC").per(PER)
        render 'main/main'
    end
    def sort
        #最近順
        if params[:resent]
            @boards_like = Board.page(params[:page]).order(created_at:"DESC").per(PER)
            @active_id="tab_resent"
        #いいね順
        elsif params[:like]
            @boards_like = Board.page(params[:page]).order("likes_count DESC").order("view DESC").per(PER)
            @active_id="tab_like"
        #照会数順
        elsif params[:see]
            @boards_like = Board.page(params[:page]).order("view DESC").order("likes_count DESC").per(PER)
            @active_id="tab_see"
        #コメント順
        elsif params[:comment]
            @boards_like = Board.page(params[:page]).left_joins(:comments).group(:id).order('COUNT(comments.commentable_id) DESC').per(PER) 
            @active_id="tab_comment"
        end
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
